//
//  Refreshable.swift
//  KivraTask
//
//  Created by Ramon Vasconcelos on 27/03/2019.
//  Copyright © 2019 Ramon Vasconcelos. All rights reserved.
//

import UIKit

/// Adds a pull to refresh item to a view controller. Code borrowed from https://christiantietze.de/posts/2017/04/protocol-ui-mixin/
@objc protocol Refreshable
{
    /// The refresh control
    var refreshControl: UIRefreshControl? { get set }

    /// The table view
    var tableView: UITableView! { get set }

    /// the function to call when the user pulls down to refresh
    @objc func handleRefresh(_ sender: Any);
}


extension Refreshable where Self: UIViewController
{
    /// Install the refresh control on the table view
    func installRefreshControl()
    {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .gray
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        self.refreshControl = refreshControl

        if #available(iOS 10.0, *)
        {
            tableView.refreshControl = refreshControl
        }
        else
        {
            tableView.backgroundView = refreshControl
        }
    }
}
