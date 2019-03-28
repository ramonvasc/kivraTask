//
//  ErrorHandler.swift
//  KivraTask
//
//  Created by Ramon Vasconcelos on 27/03/2019.
//  Copyright © 2019 Ramon Vasconcelos. All rights reserved.
//

import UIKit

class ErrorHandler {

    /**
     Handles the corresponding error on the main thread

     - Parameter errorHandler: The handler that will escape.
     - Parameter error: The error that should be handled.

     */
    static func handleError(errorHandler: @escaping(_ error: Error) -> Void, error: Error) {
        DispatchQueue.main.async {
            errorHandler(error)
        }
    }

}
