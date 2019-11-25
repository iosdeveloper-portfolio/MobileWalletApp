//
//  AlertController.swift
//  MobileWalletDemo
//


import UIKit

class AlertController {
    
    private var alertController: UIAlertController
    
    public init(alertTitle title: String, message: String? = nil) {
        self.alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    public init(actionSheetTitle title: String, message: String? = nil) {
        self.alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    }
    
    @discardableResult
    public func addAction(title: String, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)?) -> Self {
        alertController.addAction(UIAlertAction(title: title, style: style, handler: handler))
        return self
    }
    
    @discardableResult
    public func build() -> UIAlertController {
        return alertController
    }
    
    public func show(inView: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            inView.present(self.build(), animated: animated, completion: completion)
        }
    }
}

extension UIAlertController {
    public func show(inView: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            inView.present(self, animated: animated, completion: completion)
        }
    }
}
