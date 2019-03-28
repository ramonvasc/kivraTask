//
//  UserService.swift
//  KivraTask
//
//  Created by Ramon Vasconcelos on 27/03/2019.
//  Copyright © 2019 Ramon Vasconcelos. All rights reserved.
//

import UIKit

protocol UserService {

    /**
     Authenticates and returns an user after posting client credentials on kivra's api

     - Parameter endpoint: The endpoint from where authentication can be fetched.
     - Parameter params: Any params required by the api. In this case username and password
     - Parameter successHandler: Handles back the fetched user when urlRequest is done.
     - Parameter errorHandler: Handles back and error in case urlRequest can't be completed.

     */
    func fetchUser(from endpoint: Endpoint, params: [String: String]?, successHandler: @escaping (_ response: User) -> Void, errorHandler: @escaping(_ error: Error) -> Void)

}
