//
// HomeViewController.swift
// MobileWalletDemo
//

import UIKit

enum SectionTypes: CaseIterable {
    case balance
    case walletStatus
    case report
}

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    
    private(set) var sectionTypes: [SectionTypes] = SectionTypes.allCases
    private var presenter = HomePresenter(provider: HomeProvider())
    
    @IBOutlet var transferAmountView: UIView!
    @IBOutlet weak var transferAmountCloseButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var transferAmountTextField: UITextField!
    @IBOutlet weak var availableBalanceLabel: UILabel!
    @IBOutlet weak var payAmountButton: UIButton!
    
    @IBOutlet var addAmountView: UIView!
    @IBOutlet weak var addAmountCloseButton: UIButton!
    @IBOutlet weak var enterAmountTextField: UITextField!
    @IBOutlet weak var addMoneyButton: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.setLogoutButton()
    }
    
    func setupUI() {
        self.view.backgroundColor = UIColor.secondary
        
        presenter.attachView(view: self)
        presenter.loadBalance()
        presenter.fetchReports()
        
        self.transferAmountView.hideView(withAnimations: false)

        self.view.addSubview(self.transferAmountView)
        
        payAmountButton.layer.cornerRadius = self.payAmountButton.frame.height / 2
        payAmountButton.layer.borderColor = UIColor.appColor.cgColor
        payAmountButton.layer.borderWidth = 1.0
        payAmountButton.setTitleColor(UIColor.primaryText, for: .normal)
        payAmountButton.setTitle(LocalizedString.Constants.sendMoney, for: .normal)
        
        addMoneyButton.layer.cornerRadius = self.addMoneyButton.frame.height / 2
        addMoneyButton.layer.borderColor = UIColor.appColor.cgColor
        addMoneyButton.layer.borderWidth = 1.0
        addMoneyButton.setTitleColor(UIColor.primaryText, for: .normal)
        addMoneyButton.setTitle(LocalizedString.Constants.addMoney, for: .normal)
        
        addAmountCloseButton.tintColor = UIColor.primaryText
        transferAmountCloseButton.tintColor = UIColor.primaryText
        
        enterAmountTextField.textColor = UIColor.primaryText
        enterAmountTextField.placeholder = LocalizedString.Placeholder.enterAmount
        
        usernameTextField.textColor = UIColor.primaryText
        usernameTextField.placeholder = LocalizedString.Placeholder.username
        
        transferAmountTextField.textColor = UIColor.primaryText
        transferAmountTextField.placeholder = LocalizedString.Placeholder.enterAmount
        
        homeTableView.pullToRefresh = { ref in
            ref.beginRefreshing()
            self.presenter.loadBalance(isShowProgress: false)
            self.presenter.fetchReports(isShowProgress: false)
        }
    }
    
    func setLogoutButton() {
        let logout = UIBarButtonItem(image: UIImage(named: "ic_logout"), style: .plain, target: self, action: #selector(logoutButtonAction(_:)))
        self.navigationItem.rightBarButtonItem = logout
    }
}

extension HomeViewController {
    
    @objc func transactionButtonAction(_ sender: UIButton) {
        self.transferAmountView.showView(withAnimations: true)

        usernameTextField.text = ""
        transferAmountTextField.text = ""
        usernameTextField.becomeFirstResponder()
        transferAmountView.translatesAutoresizingMaskIntoConstraints = false
        
        let amount = presenter.balance?.amount ?? "0"
        availableBalanceLabel.attributedText = (
            LocalizedString.Constants.availableBalance
                .toAttributed
                .foregroundColor(UIColor.gray)
                .font(UIFont.systemFont(ofSize: 14)) +
                
            amount.amountLocalized()
                .toAttributed
                .foregroundColor(UIColor.primaryText)
                .font(UIFont.boldSystemFont(ofSize: 14))
            ).rawValue
        
        NSLayoutConstraint.activate([
            transferAmountView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            transferAmountView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            transferAmountView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            transferAmountView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        ])
    }
    
    @IBAction func transferViewCloseButtonAction(_ sender: UIButton) {
        self.transferAmountView.hideView(withAnimations: true)
        self.view.endEditing(true)
    }
    
    @IBAction func transferPopupButtonAction(_ sender: UIButton) {
        self.presenter.transfer(withUsername: usernameTextField.text, amount: transferAmountTextField.text)
    }
    
    @objc func logoutButtonAction(_ sender: UIButton) {
        SessionManager.logoutUser()
    }
    
    @objc func addMoneyButtonAction(_ sender: UIButton) {
        self.addAmountView.showView(withAnimations: true)
        enterAmountTextField.text = ""
        enterAmountTextField.becomeFirstResponder()
        self.view.addSubview(self.addAmountView)
        addAmountView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addAmountView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            addAmountView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            addAmountView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            addAmountView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        ])
    }
    
    @IBAction func addMoneyViewCloseButtonAction(_ sender: UIButton) {
        self.addAmountView.hideView(withAnimations: true)
        self.view.endEditing(true)
    }
    
    @IBAction func addMoneyPopupButtonAction(_ sender: UIButton) {
        if let amount = enterAmountTextField.text, amount.isValid {
            self.presenter.addMoney(amount: amount)
        }
    }
}

//MARK: - UITableView
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionTypes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.sectionTypes[section] {
        case .balance, .walletStatus:
            return 1
        case .report:
            return presenter.reportResults.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.sectionTypes[indexPath.section] {
        case .balance:
            let cell = tableView.dequeueReusableCell(withClassName: BalanceTableViewCell.self, for: indexPath)
            cell.selectionStyle = .none
            cell.configure(withBalance: presenter.balance?.amount)
            return cell
            
        case .walletStatus:
            let cell = tableView.dequeueReusableCell(withClassName: WalletStatusTableViewCell.self, for: indexPath)
            cell.transactionButton.addTarget(self, action: #selector(transactionButtonAction(_:)), for: .touchUpInside)
            cell.issueButton.addTarget(self, action: #selector(addMoneyButtonAction(_:)), for: .touchUpInside)
            return cell
            
        case .report:
            
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withClassName: TransferStatementTableViewCell.self, for: indexPath)
                cell.headerTitleLabel.text = presenter.reportResults.isEmpty ? LocalizedString.Constants.noTransactionFound : LocalizedString.Constants.transactionHistory
                cell.selectionStyle = .none
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withClassName: ReportTableViewCell.self, for: indexPath)
                cell.configure(withReport: presenter.reportResults[indexPath.row - 1])
                cell.selectionStyle = .none
                cell.layoutSubviews()
                return cell
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension HomeViewController: HomeView {
    func requestAndValidationFailure(withError error: String?) {
        if let errorMessage = error {
            AlertController(alertTitle: LocalizedString.Alert.genericTitle, message: errorMessage)
                .addAction(title: LocalizedString.Alert.ok, style: .default, handler: nil)
                .show(inView: self)
        }
    }
    
    func balanceRequestSuccess(withBalance balance: BalanceResponse) {
        if !self.addAmountView.isHidden {
            self.addAmountView.hideView(withAnimations: true)
        }
        homeTableView.endRefreshing()
        self.homeTableView.reloadData()
    }
    
    func reportRequestSuccess(withReport report: ReportResponse) {
        if !self.transferAmountView.isHidden {
            self.transferAmountView.hideView(withAnimations: true)
        }
        homeTableView.endRefreshing()
        self.homeTableView.reloadData()
    }
}
