//
// BalanceTableViewCell.swift
// MobileWalletDemo
//

import UIKit

class BalanceTableViewCell: UITableViewCell {

    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var totalBalanceLabel: UILabel!
    @IBOutlet weak var currentDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        balanceLabel.text = LocalizedString.Constants.balance
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        currentDateLabel.text = dateFormatter.string(from: Date())
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(withBalance balance: String?) {
        totalBalanceLabel.text = (balance ?? "0").amountLocalized()
        totalBalanceLabel.textColor = .priceReceiveText
    }
}
