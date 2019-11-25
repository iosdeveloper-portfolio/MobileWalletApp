//
// WalletStatusTableViewCell.swift
// MobileWalletDemo
//

import UIKit

class WalletStatusTableViewCell: UITableViewCell {

    @IBOutlet weak var transactionButton: UIButton!
    @IBOutlet weak var issueButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        for button in [transactionButton, issueButton] {
            button?.applyCardStyle(cornerRadius: 5)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


