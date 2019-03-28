//
//  UserAuthenticationViewController.swift
//  KivraTask
//
//  Created by Ramon Vasconcelos on 27/03/2019.
//  Copyright © 2019 Ramon Vasconcelos. All rights reserved.
//

import UIKit

class UserAuthenticationViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var authenticateButton: UIButton!
    private var authenticationViewModel: AuthenticationViewModel?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAuthenticationViewModel()
    }

    private func setAuthenticationViewModel() {
        authenticationViewModel = AuthenticationViewModel(endpoint: .authentication, userService: UserStore.shared, delegate: self)
    }

    @IBAction func authenticate(_ sender: UIButton) {
        guard let email = emailTextField.text, email != "", let password = passwordTextField.text, password != "" else {
            showAlert(title: "try_again".localized, msg: "missing_info".localized)
            return
        }
        authenticationViewModel?.getUser(for: email, and: password)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.unreadMessagesSegueIdentifier, let destinationVc = segue.destination as? MessagesViewController else {
            return
        }
        destinationVc.userViewModel = authenticationViewModel?.viewModelForUser()
    }
}

extension UserAuthenticationViewController: AuthenticationViewModelDelegate {

    func didGetLastUsedEmail(email: String) {
        emailTextField.text = email
        passwordTextField.text = ""
    }

    func didReceiveResponse(error: Error?) {
        guard let error = error else {
            performSegue(withIdentifier: Constants.unreadMessagesSegueIdentifier, sender: nil)
            return
        }
        showAlert(title: "try_again".localized, msg: error.localizedDescription)
    }

}
