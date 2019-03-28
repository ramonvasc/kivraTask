//
//  MessagesCell.swift
//  KivraTask
//
//  Created by Ramon Vasconcelos on 27/03/2019.
//  Copyright © 2019 Ramon Vasconcelos. All rights reserved.
//

import UIKit

class MessagesCell: UITableViewCell {

    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var senderName: UILabel!
    @IBOutlet weak var createdAt: UILabel!

    /**
     Configures the cell based on the view model

     - Parameter viewModel: The view model containing information that should be displayed on the cell

     */
    func configure(viewModel: MessageViewModel) {
        selectionStyle = .none
        subject.text = viewModel.subject
        senderName.text = viewModel.senderName
        createdAt.text = viewModel.createdAt
    }
    
}
