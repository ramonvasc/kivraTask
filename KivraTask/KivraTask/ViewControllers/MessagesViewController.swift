//
//  MessagesViewController.swift
//  KivraTask
//
//  Created by Ramon Vasconcelos on 27/03/2019.
//  Copyright © 2019 Ramon Vasconcelos. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController, Refreshable {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    private var messageListViewModel: MessageListViewModel?
    var userViewModel: UserViewModel?
    var refreshControl: UIRefreshControl?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        installRefreshControl()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setMessageListViewViewModel()
    }

    private func setMessageListViewViewModel() {
        guard let userViewModel = userViewModel else {
            return
        }
        messageListViewModel = MessageListViewModel(endpoint: .unreadMessages, userViewModel: userViewModel, messageService: MessageStore.shared, delegate: self)
    }

    private func animateActivityIndicator() {
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden = false
    }

    private func stopAnimateActivityIndicator() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }

    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: Constants.messagesCellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.messagesCellIdentifier)
    }

    func handleRefresh(_ sender: Any) {
        refreshControl?.endRefreshing()
        messageListViewModel?.refreshMessages()
    }

}

extension MessagesViewController: MessageListViewModelDelegate {

    func didReceiveResponse(error: Error?) {
        stopAnimateActivityIndicator()
        tableView.reloadData()
        infoLabel.isHidden = !(messageListViewModel?.hasError ?? false)
        infoLabel.text = error?.localizedDescription
    }

}

extension MessagesViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageListViewModel?.numberOfMessages ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.messagesCellIdentifier, for: indexPath) as! MessagesCell
        if let viewModel = messageListViewModel?.viewModelForMessage(at: indexPath.row) {
            cell.configure(viewModel: viewModel)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            messageListViewModel?.deleteMessage(at: indexPath.row)
            tableView.reloadData()
        }
    }

}
