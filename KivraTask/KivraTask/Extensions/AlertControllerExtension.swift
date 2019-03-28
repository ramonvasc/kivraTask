//
//  AlertControllerExtension.swift
//  KivraTask
//
//  Created by Ramon Vasconcelos on 27/03/2019.
//  Copyright © 2019 Ramon Vasconcelos. All rights reserved.
//

import UIKit

extension UIViewController {

    /**
     Presents an UIAlertController with custom title and message

     - Parameter title: Custom title for UIAlertController
     - Parameter msg: Custom message for UIAlertController

     */
    func showAlert(title: String?, msg: String?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

}
