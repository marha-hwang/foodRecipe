//
//  CustomTabbar.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/25.
//

import Foundation
import UIKit

class CustomTabBarController:UITabBarController{
    override func viewDidLoad() {
        tabBar.backgroundColor = UIColor(hex: "e1e9f0", alpha: 1.0)
        tabBar.tintColor = .black
    }
}
