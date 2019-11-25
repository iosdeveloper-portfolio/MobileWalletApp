//
// UIColor+Extension.swift
// MobileWalletDemo
//

import UIKit

extension UIColor {
    
    static let appColor = UIColor(rgb: 0x082E4D)
    static let secondary = UIColor(rgb: 0x5A9DD4)
    
    static let primaryText = UIColor(rgb: 0x082E4D)
    
    static let priceReceiveText = UIColor(rgb: 0x34C759)
    static let priceSendText = UIColor(rgb: 0xff2800)
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
