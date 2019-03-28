//
//  MessageError.swift
//  KivraTask
//
//  Created by Ramon Vasconcelos on 27/03/2019.
//  Copyright © 2019 Ramon Vasconcelos. All rights reserved.
//

import UIKit

enum MessageError: Error {

    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError

}
