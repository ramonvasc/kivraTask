//
//  AuthenticationViewModel.swift
//  KivraTask
//
//  Created by Ramon Vasconcelos on 27/03/2019.
//  Copyright © 2019 Ramon Vasconcelos. All rights reserved.
//

import UIKit

protocol AuthenticationViewModelDelegate: class {
    func didReceiveResponse(error: Error?)
    func didGetLastUsedEmail(email: String)
}

class AuthenticationViewModel {

    private let userService: UserService
    private let endpoint: Endpoint
    private var user: User?
    var isFetching = false
    var error: Error?
    var hasError: Bool {
        return error != nil
    }

    weak var delegate: AuthenticationViewModelDelegate?

    /**
     Creates an AuthenticationViewModel and tries to fetch last used user's email if available

     - Parameter endpoint: The endpoint where authentication is done
     - Parameter userService: Instance of UserService to be used on the view model
     - Parameter delegate: The delegate who will respond to this view model

     */
    init(endpoint: Endpoint, userService: UserService, delegate: AuthenticationViewModelDelegate?) {
        self.userService = userService
        self.endpoint = endpoint
        self.delegate = delegate
        self.fetchLastUsedEmail()
    }

    /**
     Create a UserViewModel for a user

     - Returns: The view model of the user

     */
    func viewModelForUser() -> UserViewModel? {
        guard let user = user else {
            return nil
        }
        return UserViewModel(user: user)
    }

    /**
     Tries to authenticate an user and saves the used email

     - Parameter email: User's email
     - Parameter password: User's password

     */
    func getUser(for email: String, and password: String) {
        save(email: email)
        getUser(from: endpoint, for: email, and: password)
    }

    private func fetchLastUsedEmail(){
        let userDefaults = UserDefaults.standard
        guard let lastUsedEmail = userDefaults.string(forKey: "LastUsedEmail") else {
            return
        }
        delegate?.didGetLastUsedEmail(email: lastUsedEmail)
    }

    private func save(email: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(email, forKey: "LastUsedEmail")
    }

    private func getUser(from endpoint: Endpoint, for email: String, and password: String) {
        user = nil
        isFetching = true
        error = nil
        let params = ["username": email,
                      "password": password]
        userService.fetchUser(from: endpoint, params: params, successHandler: { [weak self] (response) in
            self?.isFetching = false
            self?.user = User(resource_owner: response.resource_owner, access_token: response.access_token)
            self?.delegate?.didReceiveResponse(error: nil)
        }) { [weak self] (error) in
            self?.isFetching = false
            self?.error = error
            self?.delegate?.didReceiveResponse(error: error)
        }
    }

}
