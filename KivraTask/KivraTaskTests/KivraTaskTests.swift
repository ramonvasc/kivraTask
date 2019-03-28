//
//  KivraTaskTests.swift
//  KivraTaskTests
//
//  Created by Ramon Vasconcelos on 27/03/2019.
//  Copyright © 2019 Ramon Vasconcelos. All rights reserved.
//

import XCTest
@testable import KivraTask

class KivraTaskTests: XCTestCase {

    func testUserAuthentication() {
        let params = ["username": "ramon@kivra.fi",
                      "password": "321helloWORLD"]
        let expectation = XCTestExpectation(description: "Download User")

        UserStore().fetchUser(from: .authentication, params: params, successHandler: { (response) in
            let user = User(resource_owner: response.resource_owner, access_token: response.access_token)
            let userViewModel = UserViewModel(user: user)
            print("User -------> \(userViewModel)")
            expectation.fulfill()
            XCTAssert(userViewModel.accessToken != "" && userViewModel.userId != "")
        }) { (error) in
            print("Error -------> \(error)")
            XCTAssert(false)
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchMessages() {
        let params = ["username": "ramon@kivra.fi",
                      "password": "321helloWORLD"]
        let userExpectation = XCTestExpectation(description: "Download User")
        let messagesExpectation = XCTestExpectation(description: "Download Messages")

        UserStore().fetchUser(from: .authentication, params: params, successHandler: { (response) in
            let user = User(resource_owner: response.resource_owner, access_token: response.access_token)
            userExpectation.fulfill()
            let userViewModel = UserViewModel(user: user)
            MessageStore().fetchMessages(from: .unreadMessages, for: userViewModel, successHandler: { (response) in
                guard let firstMessage = response.first else {
                    XCTAssert(false)
                    return
                }
                print("Messages -------> \(firstMessage)")
                let messageViewModel = MessageViewModel(message: firstMessage)
                messagesExpectation.fulfill()
                XCTAssert(messageViewModel.createdAt != "" && messageViewModel.senderName != "" && messageViewModel.subject != "")
            }) { (error) in
                print("Error -------> \(error)")
                XCTAssert(false)
            }
        }) { (error) in
            print("Error -------> \(error)")
            XCTAssert(false)
        }
        wait(for: [userExpectation, messagesExpectation], timeout: 5.0)

    }

}
