//
//  UIColor+init.swift
//  UISample
//
//  Created by h2o on 2024/07/16.
//

import Foundation
import UIKit

///hex값을 이용하여 UIColor을 생성하기 위해 extention
///ex) UIColor(hex: "ECEDE4", alpha: 1.0)
extension UIColor{
    convenience init(hex:String, alpha:CGFloat) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
                    hexFormatted = String(hexFormatted.dropFirst())
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
                
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
        
    }
}
