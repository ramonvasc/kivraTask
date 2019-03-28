//
//  MessageStore.swift
//  KivraTask
//
//  Created by Ramon Vasconcelos on 27/03/2019.
//  Copyright © 2019 Ramon Vasconcelos. All rights reserved.
//

import UIKit

class MessageStore: MessageService {

    static let shared = MessageStore()

    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        return jsonDecoder
    }()

    func fetchMessages(from endpoint: Endpoint, for user: UserViewModel, successHandler: @escaping ([Message]) -> Void, errorHandler: @escaping (Error) -> Void) {

        guard let urlComponents = URLComponents(string: "\(Constants.baseApiUrl)user/\(user.userId)/\(endpoint.rawValue)") else {
            errorHandler(MessageError.invalidEndpoint)
            return
        }

        let header = ["Authorization": "bearer \(user.accessToken)"]

        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = header
        let session = URLSession(configuration: config)

        let task = session.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                ErrorHandler.handleError(errorHandler: errorHandler, error: MessageError.apiError)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                ErrorHandler.handleError(errorHandler: errorHandler, error: MessageError.invalidResponse)
                return
            }

            guard let data = data else {
                ErrorHandler.handleError(errorHandler: errorHandler, error: MessageError.noData)
                return
            }

            do {
                let messagesResponse = try self.jsonDecoder.decode([Message].self, from: data)
                DispatchQueue.main.async {
                    successHandler(messagesResponse)
                }
            } catch {
                ErrorHandler.handleError(errorHandler: errorHandler, error: MessageError.serializationError)
            }
        }

        task.resume()

    }

}
