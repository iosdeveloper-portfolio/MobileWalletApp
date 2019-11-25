//
//  UIButton+Extension.swift
//  MobileWalletDemo
//


import Foundation
import UIKit

extension UIButton {
    
    func applyCardStyle(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = UIColor.darkText.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.4
    }
}

extension UIView {
    
    func showView(withAnimations animations: Bool) {
        self.isHidden = false
        if animations {
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 1
            }) { _ in
                self.alpha = 1
            }
        } else {
            self.alpha = 1
        }
    }
    
    func hideView(withAnimations animations: Bool) {
        if animations {
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 0
            }) { _ in
                self.isHidden = true
                self.alpha = 0
            }
        } else {
            self.isHidden = true
            self.alpha = 0
        }
    }
}
