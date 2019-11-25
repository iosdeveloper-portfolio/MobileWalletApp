//
//  ViewController.swift
//  MobileWalletDemo
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var signupTitleLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var signUpButton: UIButton!
    
    private let presenter = SignUpPresenter(provider: SignUpProvider())
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupUI()
        presenter.attachView(view: self)
    }

    func setupUI() {
        signUpButton.layer.cornerRadius = self.signUpButton.frame.height / 2
        signUpButton.layer.borderColor = UIColor.appColor.cgColor
        signUpButton.layer.borderWidth = 1.0
        signUpButton.setTitleColor(UIColor.primaryText, for: .normal)
        signUpButton.setTitle(LocalizedString.Constants.signup, for: .normal)
        
        self.view.backgroundColor = UIColor.secondary
        
        usernameTextField.textColor = UIColor.primaryText
        usernameTextField.placeholder = LocalizedString.Placeholder.username
        
        passwordTextField.textColor = UIColor.primaryText
        passwordTextField.placeholder = LocalizedString.Placeholder.password
        
        signupTitleLabel.text = LocalizedString.Constants.signup
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        self.view.endEditing(true)
        self.presenter.signup(withUsername: usernameTextField.text, password: passwordTextField.text)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
}

extension SignUpViewController: SignUpView {
    
    func requestAndValidationFailure(withError error: String?) {
        if let errorMessage = error {
            AlertController(alertTitle: LocalizedString.Alert.genericTitle, message: errorMessage)
                .addAction(title: LocalizedString.Alert.ok, style: .default, handler: nil)
                .show(inView: self)
        }
    }
    
    func requestSuccess() {
        AlertController(alertTitle: LocalizedString.Alert.genericTitle, message: LocalizedString.Constants.signedUpSuccess)
            .addAction(title: LocalizedString.Alert.ok, style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            })
            .show(inView: self)
    }
}
