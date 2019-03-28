//
//  User.swift
//  KivraTask
//
//  Created by Ramon Vasconcelos on 27/03/2019.
//  Copyright © 2019 Ramon Vasconcelos. All rights reserved.
//

import UIKit

/// User struct representing kivra's api, the names should be the same as the api
struct User: Codable {

    let resource_owner: String
    let access_token: String

}
