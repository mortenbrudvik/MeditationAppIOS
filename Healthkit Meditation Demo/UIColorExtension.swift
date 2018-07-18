//
//  UIColorExtension.swift
//  Healthkit Meditation Demo
//
//  Created by Morten Brudvik on 18/07/2018.
//  Copyright © 2018 Morten Brudvik. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
    
    static let flatMint: UIColor = UIColor(red: 0x42, green: 0xC9, blue: 0x77)
    static let flatMintDark: UIColor = UIColor(red: 0x37, green: 0xAC, blue: 0x66)
    static let flatWhite: UIColor = UIColor(red: 0xF7, green: 0xFD, blue: 0xFF)
    static let flatWhiteDark: UIColor = UIColor(red: 0xBD, green: 0xC3, blue: 0xC7)
    static let flatBlack: UIColor = UIColor(red: 0x26, green: 0x26, blue: 0x26)
    static let flatGrayDark: UIColor = UIColor(red: 0x2D, green: 0x50, blue: 0x36)
}
