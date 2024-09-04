//
//  RecipeDetailViewController.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import UIKit

class RecipeDetailViewController: UIViewController{
    private var viewModel: RecipeDetailViewModel!
    private var recipeImageRepository:RecipeImageRepository?
    
    static func create(with viewModel:RecipeDetailViewModel,
                       recipeImageRepository:RecipeImageRepository
    ) -> RecipeDetailViewController {
        let vc = RecipeDetailViewController()
        vc.viewModel = viewModel
        vc.recipeImageRepository = recipeImageRepository
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        print(viewModel.recipe.recipe_name)
        
        outer.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        status.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        outer.addSubview(name)
        name.text = viewModel.recipe.recipe_name
        
        outer.addSubview(status)
        viewModel.favoriteStatus.observe(on: self){_ in 
            status.text = self?.viewModel.favoriteStatus.value
        }
        
        outer.addSubview(button)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(searchButtonEvent)) 
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc private func searchButtonEvent(sender: UITapGestureRecognizer){
        viewModel.didTouchFavorite()
    }
     
    var outer:UIView = UIView(frame: CGRect(x: 50, y: 50, width: 300, height: 300))
    var name = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 50))
    var status = UILabel(frame: CGRect(x: 10, y: 120, width: 100, height: 50))
    var button = UIView(frame: CGRect(x: 10, y: 240, width: 100, height: 50))
}
