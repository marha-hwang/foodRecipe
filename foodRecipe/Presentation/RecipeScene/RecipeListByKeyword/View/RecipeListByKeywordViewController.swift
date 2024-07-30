//
//  RecipeListByKeywordViewController.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/22.
//


import UIKit

class RecipeListByKeywordViewController: UIViewController{
    private var viewModel: RecipeMainViewModel!
    private var recipeMainView:RecipeMainView!
    
    static func create() -> RecipeListByKeywordViewController {
        let vc = RecipeListByKeywordViewController()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}
