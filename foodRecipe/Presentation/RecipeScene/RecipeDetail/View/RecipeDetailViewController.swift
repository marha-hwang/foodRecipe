//
//  RecipeDetailViewController.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import UIKit

class RecipeDetailViewController: UIViewController{
    private var viewModel: RecipeMainViewModel!
    private var recipeMainView:RecipeMainView!
    
    static func create() -> RecipeDetailViewController {
        let vc = RecipeDetailViewController()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
    }
}
