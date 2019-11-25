//
// CardView.swift
// MobileWalletDemo
//

import UIKit

class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 5
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 2, height: 2)
    @IBInspectable var shadowColor: UIColor = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.4
    @IBInspectable var shadowRadius: CGFloat = 3

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)

        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowPath = shadowPath.cgPath
    }
}
