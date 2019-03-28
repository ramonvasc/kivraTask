//
//  UserStore.swift
//  KivraTask
//
//  Created by Ramon Vasconcelos on 27/03/2019.
//  Copyright © 2019 Ramon Vasconcelos. All rights reserved.
//

import UIKit

class UserStore: UserService {

    static let shared = UserStore()

    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        return jsonDecoder
    }()

    func fetchUser(from endpoint: Endpoint, params: [String : String]?, successHandler: @escaping (User) -> Void, errorHandler: @escaping (Error) -> Void) {

        guard let urlComponents = URLComponents(string: "\(Constants.baseApiUrl)\(endpoint.rawValue)"),
            let params = params else {
            errorHandler(MessageError.invalidEndpoint)
            return
        }

        let json: [String: Any] = ["grant_type": "implicit",
                                   "redirect_uri": Constants.redirectUri,
                                   "client_id": Constants.clientId,
                                   "username": params["username"] ?? "",
                                   "password": params["password"] ?? ""]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        let header = ["Content-Type": "application/json"]

        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = "POST"
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = header
        let session = URLSession(configuration: config)
        urlRequest.httpBody = jsonData

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
                let authenticationResponse = try self.jsonDecoder.decode(User.self, from: data)
                DispatchQueue.main.async {
                    successHandler(authenticationResponse)
                }
            } catch {
                ErrorHandler.handleError(errorHandler: errorHandler, error: MessageError.serializationError)
            }
        }

        task.resume()
    }

}
