//
//  RecipeListByKeywordViewController.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/22.
//


import UIKit

class RecipeListByKeywordViewController: UIViewController{
//    private var viewModel: RecipeMainViewModel!
//    private var recipeMainView:RecipeMainView!
    var keyword:String!
    
    
    static func create(keyword:String) -> RecipeListByKeywordViewController {
        let vc = RecipeListByKeywordViewController()
        vc.keyword = keyword
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        let label = UILabel()
        print(keyword)
        label.text = keyword
        
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 200).isActive = true
        label.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        label.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 100).isActive = true
    }
}
