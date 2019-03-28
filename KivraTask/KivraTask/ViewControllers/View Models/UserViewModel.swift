//
//  UserViewModel.swift
//  KivraTask
//
//  Created by Ramon Vasconcelos on 27/03/2019.
//  Copyright © 2019 Ramon Vasconcelos. All rights reserved.
//

import UIKit

struct UserViewModel {

    private var user: User

    init(user: User) {
        self.user = user
    }

    /// Returns the user id formmated without user_
    var userId: String {
        return String(user.resource_owner.split(separator: "_").last ?? "")
    }

    var accessToken: String {
        return user.access_token
    }

}
