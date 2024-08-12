//
//  RecipeListByCategoryViewController.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/22.
//

import UIKit

class RecipeListByCategoryViewController: UIViewController{
    private var viewModel: RecipeMainViewModel!
    private var recipeMainView:RecipeMainView!
    
    static func create() -> RecipeListByCategoryViewController {
        let vc = RecipeListByCategoryViewController()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
    }
}
