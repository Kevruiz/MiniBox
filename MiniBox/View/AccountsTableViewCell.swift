//
//  AccountsTableViewCell.swift
//  MiniBox
//
//  Created by kevin on 10/01/2022.
//

import UIKit

class AccountsTableViewCell: UITableViewCell {

    @IBOutlet weak var userAccounts: UIView!
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var planValue: UILabel!
    @IBOutlet weak var moneyBox: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
