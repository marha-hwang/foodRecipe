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
    
    var name = UILabel()
    var status = UILabel()
    var button = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        print(viewModel.recipe.recipe_name)
        viewModel.viewDidLoad()
        
        name.translatesAutoresizingMaskIntoConstraints = false
        status.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        name.text = viewModel.recipe.recipe_name
        
        viewModel.favoriteStatus.observe(on: self){_ in 
            DispatchQueue.main.async{
                self.status.text = self.viewModel.favoriteStatus.value == true ? "true":"false"   
            }
        }
        
        button.backgroundColor = .black
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(searchButtonEvent)) 
        button.isUserInteractionEnabled = true
        button.addGestureRecognizer(gestureRecognizer)
        
        view.addSubview(name)
        view.addSubview(status)
        view.addSubview(button)
        
        name.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        name.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        name.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        status.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 30).isActive = true
        status.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        status.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        button.topAnchor.constraint(equalTo: status.bottomAnchor, constant: 30).isActive = true
        button.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    @objc private func searchButtonEvent(sender: UITapGestureRecognizer){
        viewModel.didTouchFavorite()
    }
}
