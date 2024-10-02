//
//  UIStackView+setType.swift
//  foodRecipe
//
//  Created by h2o on 2024/09/12.
//

import Foundation
import UIKit

extension UIStackView{
    convenience init(axis: NSLayoutConstraint.Axis, distribution:Distribution, alignment:Alignment){
        self.init()
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addBorder(_ edgeArr:[UIRectEdge], width:CGFloat, color:UIColor){
        edgeArr.forEach{ edge in
            let line = UIView()
            self.addSubview(line)
            switch edge{
            case .top:
                line.snp.makeConstraints{ make in
                    make.leading.top.equalToSuperview()
                    make.height.equalTo(width)
                    make.width.equalToSuperview()
                }
            case .bottom:
                line.snp.makeConstraints{ make in
                    make.leading.bottom.equalToSuperview()
                    make.height.equalTo(width)
                    make.width.equalToSuperview()
                }
            case .left:
                line.snp.makeConstraints{ make in
                    make.leading.top.equalToSuperview()
                    make.width.equalTo(width)
                    make.height.equalToSuperview()
                }
            case .right:
                line.snp.makeConstraints{ make in
                    make.trailing.top.equalToSuperview()
                    make.width.equalTo(width)
                    make.height.equalToSuperview()
                }            
            default:
                break
            }
            
            line.backgroundColor = color
        }
        
        
    }
}
