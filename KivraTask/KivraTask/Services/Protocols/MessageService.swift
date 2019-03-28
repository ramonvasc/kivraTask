//
//  MessageService.swift
//  KivraTask
//
//  Created by Ramon Vasconcelos on 27/03/2019.
//  Copyright © 2019 Ramon Vasconcelos. All rights reserved.
//

import UIKit

protocol MessageService {

    /**
     Gets user's messages from kivra's api

     - Parameter endpoint: The endpoint from where messages can be fetched.
     - Parameter user: The UserViewModel containing userId and accessToken information.
     - Parameter successHandler: Handles back the fetched messages when urlRequest is done.
     - Parameter errorHandler: Handles back and error in case urlRequest can't be completed.

     */
    func fetchMessages(from endpoint: Endpoint, for user: UserViewModel, successHandler: @escaping (_ response: [Message]) -> Void, errorHandler: @escaping(_ error: Error) -> Void)

}
