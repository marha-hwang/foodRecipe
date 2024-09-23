//
//  Double+adjust.swift
//  foodRecipe
//
//  Created by h2o on 2024/09/23.
//

import Foundation
import UIKit

extension Double{
    var adjustH:Double {
        let height = (UIScreen.main.bounds.height/852)*self
        return height.rounded()
    }
    var adjustW:Double {
        let width = (UIScreen.main.bounds.width/393)*self
        return width.rounded()
    }
}
