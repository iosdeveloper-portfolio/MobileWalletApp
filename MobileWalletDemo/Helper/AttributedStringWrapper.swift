//
//  AttributedStringWrapper.swift
//  ARDemo
//
//  Created by Nishant on 19/06/19.
//  Copyright © 2019 Nishant. All rights reserved.
//

import UIKit
import Foundation

public extension String {
    var toAttributed: AttributedStringWrapper {
        return AttributedStringWrapper(rawValue: NSMutableAttributedString(string: self))
    }
}

public struct AttributedStringWrapper: RawRepresentable {
    public typealias RawValue = NSMutableAttributedString
    public var rawValue: NSMutableAttributedString
    public init(rawValue: AttributedStringWrapper.RawValue) {
        self.rawValue = rawValue
    }
}

public extension AttributedStringWrapper {
    
    typealias ParagraphStyleSetup = (NSMutableParagraphStyle) -> Void
    typealias ShadowStyleSetup = (NSShadow) -> Void
    
    @available(iOS 9.0, *)
    typealias WriteDirection = (formatType: NSWritingDirectionFormatType, direction: NSWritingDirection)
    
    var allRange: NSRange {
        return NSMakeRange(0, self.rawValue.length)
    }
    
    @discardableResult
    func paragraph(range: NSRange? = nil, setup: ParagraphStyleSetup) -> AttributedStringWrapper {
        let paragraphStyle = NSMutableParagraphStyle()
        setup(paragraphStyle)
        rawValue.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle],
                               range: range ?? allRange)
        return self
    }
    
    @discardableResult
    func foregroundColor(_ color: UIColor, range: NSRange? = nil) -> AttributedStringWrapper {
        rawValue.addAttributes([NSAttributedString.Key.foregroundColor: color],
                               range: range ?? allRange)
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont, range: NSRange? = nil) -> AttributedStringWrapper {
        rawValue.addAttributes([NSAttributedString.Key.font: font],
                               range: range ?? allRange)
        return self
    }
    
    @discardableResult
    func backgroundColor(_ color: UIColor, range: NSRange? = nil) -> AttributedStringWrapper {
        rawValue.addAttributes([NSAttributedString.Key.backgroundColor: color],
                               range: range ?? allRange)
        return self
    }

    @discardableResult
    func strikethrough(style: [NSUnderlineStyle],
                       color: UIColor? = nil,
                       range: NSRange? = nil) -> AttributedStringWrapper {

        rawValue.addAttributes([NSAttributedString.Key.strikethroughStyle: style.reduce(0) { $0 | $1.rawValue }, NSAttributedString.Key.baselineOffset: 0], range: range ?? allRange)
        guard let color = color else { return self }
        rawValue.addAttributes([NSAttributedString.Key.strikethroughColor: color], range: range ?? allRange)
        return self
    }
    
    @discardableResult
    func underLine(style: [NSUnderlineStyle],
                   color: UIColor? = nil,
                   range: NSRange? = nil) -> AttributedStringWrapper {
        rawValue.addAttributes([NSAttributedString.Key.underlineStyle: style.reduce(0) { $0 | $1.rawValue }], range: range ?? allRange)
        guard let color = color else { return self }
        rawValue.addAttributes([NSAttributedString.Key.underlineColor: color], range: range ?? allRange)
        return self
    }
    
    @discardableResult
    func stroke(color: UIColor, width: CGFloat, range: NSRange? = nil) -> AttributedStringWrapper {
        rawValue.addAttributes([NSAttributedString.Key.strokeColor: color], range: range ?? allRange)
        rawValue.addAttributes([NSAttributedString.Key.strokeWidth: width], range: range ?? allRange)
        return self
    }
    
    /// get height, Before this, you must set the height of the text firstly
    func getHeight(by fixedWidth: CGFloat) -> CGFloat {
        let h = rawValue.boundingRect(with: CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT)), options: [.usesFontLeading , .usesLineFragmentOrigin, .usesDeviceMetrics], context: nil).size.height
        return ceil(h)
    }
    /// get width, Before this, you must set the height of the text firstly
    func getWidth(by fixedHeight: CGFloat) -> CGFloat {
        let w = rawValue.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: fixedHeight), options: [.usesFontLeading , .usesLineFragmentOrigin], context: nil).size.width
        return ceil(w)
    }
}

public func + (lf: AttributedStringWrapper, rf: AttributedStringWrapper) -> AttributedStringWrapper {
    lf.rawValue.append(rf.rawValue)
    return lf
}



