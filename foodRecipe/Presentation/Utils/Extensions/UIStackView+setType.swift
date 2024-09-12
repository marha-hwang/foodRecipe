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
    }
}
