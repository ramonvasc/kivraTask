//
//  LocalizableExtension.swift
//  KivraTask
//
//  Created by Ramon Vasconcelos on 28/03/2019.
//  Copyright © 2019 Ramon Vasconcelos. All rights reserved.
//

import UIKit

/// Access localizable strings by adding .localized. Code borrowed from https://stackoverflow.com/a/29384360/4816590
extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

