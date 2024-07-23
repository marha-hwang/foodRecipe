//
//  ViewController.swift
//  foodRecipe
//
//  Created by haram on 6/15/24.
//

import UIKit

class RecipeMainViewController: UIViewController{
    private var viewModel: RecipeMainViewModel!
    
    static func create(with viewModel: RecipeMainViewModel) -> RecipeMainViewController {
        
        let vc = RecipeMainViewController()
        vc.viewModel = viewModel
        
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let recipeMainView = RecipeMainView(
//        view.addSubview(recipeMainView)
//        recipeMainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        recipeMainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//        recipeMainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        recipeMainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        
//        recipeMainView.setLayout()
    }
        
}

