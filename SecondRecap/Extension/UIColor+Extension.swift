//
//  UIColor+Extension.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import UIKit

extension UIColor {
    static let primary = UIColor(hexCode: "914CF5")
    static let redForHigh = UIColor(hexCode: "F04452")
    static let lightRed = UIColor(hexCode: "FFEAED")
    static let blueForLow = UIColor(hexCode: "3282F8")
    static let lightBlue = UIColor(hexCode: "E5F0FF")
    static let customBlack = UIColor(hexCode: "000000")
    static let customGray = UIColor(hexCode: "828282")
    static let customLightBlack = UIColor(hexCode: "342D4C")
    static let customLightGray = UIColor(hexCode: "F3F4F6")
    static let customWhite = UIColor(hexCode: "FFFFFF")
}

extension UIColor {
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
            var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
            
            if hexFormatted.hasPrefix("#") {
                hexFormatted = String(hexFormatted.dropFirst())
            }
            
            assert(hexFormatted.count == 6, "Invalid hex code used.")
            
            var rgbValue: UInt64 = 0
            Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
            
            self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                      alpha: alpha)
        }
}
