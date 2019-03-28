//
//  Endpoint.swift
//  KivraTask
//
//  Created by Ramon Vasconcelos on 27/03/2019.
//  Copyright © 2019 Ramon Vasconcelos. All rights reserved.
//

import UIKit

enum Endpoint: String, CustomStringConvertible, CaseIterable {
    case authentication = "auth"
    case unreadMessages = "content"

    /// Formated description of endpoint
    var description: String {
        switch self {
        case .authentication: return "Authentication"
        case .unreadMessages: return "Unread Messages"
        }
    }

    /// Init and endpoint by index
    init?(index: Int) {
        switch index {
        case 0: self = .authentication
        case 1: self = .unreadMessages
        default: return nil
        }
    }

    /// Init an endpoint from it's string description
    init?(description: String) {
        guard let first = Endpoint.allCases.first(where: { $0.description == description }) else {
            return nil
        }
        self = first
    }

}
