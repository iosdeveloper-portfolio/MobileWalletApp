//
// SignInViewController.swift
// MobileWalletDemo
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var signinTitleLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    private let presenter = SignInPresenter(provider: SignInProvider())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupUI()
        presenter.attachView(view: self)
    }
    
    func setupUI() {
        signInButton.layer.cornerRadius = self.signInButton.frame.height / 2
        signInButton.layer.borderColor = UIColor.appColor.cgColor
        signInButton.layer.borderWidth = 1.0
        signInButton.setTitleColor(UIColor.primaryText, for: .normal)
        signInButton.setTitle(LocalizedString.Constants.signin, for: .normal)
        
        self.view.backgroundColor = UIColor.secondary
        
        usernameTextField.textColor = UIColor.primaryText
        usernameTextField.placeholder = LocalizedString.Placeholder.username
        
        passwordTextField.textColor = UIColor.primaryText
        passwordTextField.placeholder = LocalizedString.Placeholder.password
        
        signinTitleLabel.text = LocalizedString.Constants.signin
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        let signupText = (
            LocalizedString.Constants.dontHaveAccount
                .toAttributed
                .foregroundColor(UIColor.gray)
                .font(UIFont.systemFont(ofSize: 15)) +
            LocalizedString.Constants.signup
                .toAttributed
                .foregroundColor(UIColor.primaryText)
                .font(UIFont.boldSystemFont(ofSize: 15))
            ).rawValue
        signUpButton.setAttributedTitle(signupText, for: .normal)
    }

    @IBAction func signInClicked(_ sender: Any) {
        self.view.endEditing(true)
        self.presenter.signIn(withUsername: usernameTextField.text, password: passwordTextField.text)
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        self.view.endEditing(true)
        let vc = Storyboard.Main.instantiateViewController(withClass: SignUpViewController.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SignInViewController: SignInView {
    
    func requestAndValidationFailure(withError error: String?) {
        if let errorMessage = error {
            AlertController(alertTitle: LocalizedString.Alert.genericTitle, message: errorMessage)
                .addAction(title: LocalizedString.Alert.ok, style: .default, handler: nil)
                .show(inView: self)
        }
    }
    
    func requestSuccess(withAuth auth: AuthResponse) {
        if let accessToken = auth.accessToken?.data(using: .utf8, allowLossyConversion: false),
            KeychainService.save(key: .token, data: accessToken) {
            if let usernameData = usernameTextField.text?.data(using: .utf8, allowLossyConversion: false) {
                KeychainService.save(key: .username, data: usernameData)
            }
            let homeViewController = Storyboard.Main.instantiateViewController(withClass: HomeViewController.self)
            let navigationController = UINavigationController(rootViewController: homeViewController)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        } else {
            AlertController(alertTitle: LocalizedString.Alert.genericTitle, message: LocalizedString.Errors.genericError)
                .addAction(title: LocalizedString.Alert.ok, style: .default, handler: nil)
                .show(inView: self)
        }
    }
}
