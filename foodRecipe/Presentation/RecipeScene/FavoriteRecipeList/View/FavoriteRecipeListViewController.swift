//
//  FavoriteRecipeViewController.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/25.
//

import Foundation
import UIKit

class FavoriteRecipeListViewController:UIViewController{
    
    static func create() -> FavoriteRecipeListViewController{
        FavoriteRecipeListViewController()
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .green
    }
}
