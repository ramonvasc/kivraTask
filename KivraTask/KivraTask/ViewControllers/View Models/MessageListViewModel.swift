//
//  MessageListViewModel.swift
//  KivraTask
//
//  Created by Ramon Vasconcelos on 27/03/2019.
//  Copyright © 2019 Ramon Vasconcelos. All rights reserved.
//

import UIKit

protocol MessageListViewModelDelegate: class {
    func didReceiveResponse(error: Error?)
}

class MessageListViewModel {

    private let messageService: MessageService
    private let endpoint: Endpoint
    private let userViewModel: UserViewModel
    private var messages = [Message]()

    var isFetching = false
    var error: Error?
    var hasError: Bool {
        return error != nil
    }
    var numberOfMessages: Int {
        return messages.count
    }

    weak var delegate: MessageListViewModelDelegate?

    /**
     Creates a MessageListViewModel and tries to fetch inital messages from endpoint

     - Parameter endpoint: The endpoint where messages are located
     - Parameter userViewModel: The messager's owner
     - Parameter messageService: Instance of MessageService to be used on the view model
     - Parameter delegate: The delegate who will respond to this view model

     */
    init(endpoint: Endpoint, userViewModel: UserViewModel, messageService: MessageService, delegate: MessageListViewModelDelegate?) {
        self.messageService = messageService
        self.endpoint = endpoint
        self.delegate = delegate
        self.userViewModel = userViewModel
        self.fetchMessages(from: endpoint)
    }

    /**
     Create a MessageViewModel for a specific message

     - Parameter index: The message's index

     - Returns: The view model of that message

     */
    func viewModelForMessage(at index: Int) -> MessageViewModel? {
        guard index < messages.count else {
            return nil
        }
        return MessageViewModel(message: messages[index])
    }

    /// Refreshes all the messages on the view model
    func refreshMessages() {
        fetchMessages(from: endpoint)
    }

    /**
     Deletes a message from the view model, if index exists

     - Parameter index: The message's index

     */
    func deleteMessage(at index: Int) {
        guard messages.indices.contains(index) else {
            return
        }
        messages.remove(at: index)
    }

    private func fetchMessages(from endpoint: Endpoint) {
        messages = [Message]()
        isFetching = true
        error = nil

        messageService.fetchMessages(from: endpoint, for: userViewModel, successHandler: { [weak self] (response) in
            self?.isFetching = false
            self?.messages = response
            self?.delegate?.didReceiveResponse(error: nil)
        }) { [weak self] (error) in
            self?.isFetching = false
            self?.error = error
            self?.delegate?.didReceiveResponse(error: error)
        }
    }

}
