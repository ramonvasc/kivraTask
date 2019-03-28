//
//  MessageViewModel.swift
//  KivraTask
//
//  Created by Ramon Vasconcelos on 27/03/2019.
//  Copyright © 2019 Ramon Vasconcelos. All rights reserved.
//

import UIKit

struct MessageViewModel {

    private var message: Message

    var subject: String {
        return message.subject
    }

    var senderName: String {
        return message.sender_name
    }

    /// Returns a date string in the format yyyy-mm-dd
    var createdAt: String {
        return String(message.created_at.split(separator: "T").first ?? "")
    }

    init(message: Message) {
        self.message = message
    }

}
