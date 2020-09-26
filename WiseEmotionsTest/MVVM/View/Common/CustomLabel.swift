//
//  CustomLabel.swift
//  WiseEmotionsTest
//
//  Created by Filippo Giove on 25/09/2020.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import Foundation

import UIKit
open class CustomLabel: UILabel {

    @objc public dynamic var themeFont: UIFont!
    @objc public dynamic var themeColor: UIColor!

    @IBInspectable public var colorless: Bool = false { didSet { self.applyTheme() } }

    @objc public dynamic var themed: Bool = false { didSet { self.applyTheme() } }

    private var customTextColor: UIColor! {
        return self.colorless ? self.textColor : (self.themeColor ?? Placeholder.color)
    }



    override public func awakeFromNib() {
        super.awakeFromNib()
        self.prepare()
    }

    public func prepare() {
        applyTheme()
    }
    public func applyTheme() {
        self.font = self.themeFont ?? Placeholder.font
        self.textColor = self.customTextColor ?? Placeholder.color
    }
}
