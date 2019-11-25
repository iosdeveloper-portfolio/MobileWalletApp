//
// ReportTableViewCell.swift
// MobileWalletDemo
//

import UIKit

class ReportTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userTransactionLabel: UILabel!
    @IBOutlet weak var transactionStatusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(withReport report: ReportResults) {
        if report.to != SessionManager.username {
            userTransactionLabel.textColor = UIColor.priceSendText
            userTransactionLabel.text = "- " + (report.amount ?? "0").amountLocalized()
            userNameLabel.text = report.to ?? "Add money"
            transactionStatusLabel.text = report.from == nil ? "" : "You paid \((report.amount ?? "0").amountLocalized())"
        } else {
            userTransactionLabel.textColor = UIColor.priceReceiveText
            userTransactionLabel.text = "+ " + (report.amount ?? "0").amountLocalized()
            userNameLabel.text = report.from ?? "Add money"
            transactionStatusLabel.text = report.from == nil ? "" : "You received \((report.amount ?? "0").amountLocalized())"
        }
    }
}
