//
//  Message.swift
//  KivraTask
//
//  Created by Ramon Vasconcelos on 27/03/2019.
//  Copyright © 2019 Ramon Vasconcelos. All rights reserved.
//

import UIKit

/// Message struct representing kivra's api, the names should be the same as the api
struct Message: Codable {

    let subject: String
    let sender_name: String
    let created_at: String

}
