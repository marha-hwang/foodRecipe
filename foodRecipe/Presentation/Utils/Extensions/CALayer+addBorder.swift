//
//  CALayer+addBorder.swift
//  UISample
//
//  Created by h2o on 2024/07/16.
//

import Foundation
import UIKit

extension CALayer{
    func addBorder(_ edgeArr:[UIRectEdge], width:CGFloat, color:UIColor){
        edgeArr.forEach{ edge in
            let border = CALayer()
            switch edge{
            case .top:
                border.frame = CGRect(x: 0, y: 0, width: frame.width, height: width)
            case .bottom:
                border.frame = CGRect(x: 0, y: frame.height-width, width: frame.width, height: width)
            case .left:
                border.frame = CGRect(x: 0, y: 0, width: width, height: frame.height)
            case .right:
                border.frame = CGRect(x: frame.width-width, y: 0, width: width, height: frame.height)
            default:
                break
            }
            
            border.backgroundColor = color.cgColor
            self.addSublayer(border)
        }
        
        
    }
}
