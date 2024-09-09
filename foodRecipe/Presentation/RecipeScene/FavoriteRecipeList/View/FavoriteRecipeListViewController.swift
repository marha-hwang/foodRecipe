//
//  FavoriteRecipeViewController.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/25.
//

import Foundation
import UIKit

class FavoriteRecipeListViewController: UIViewController{
        
    private var viewModel: FavoriteRecipeListViewModel!
    private var recipeImageRepository: RecipeImageRepository?
    
    lazy var recipeTableController:FavoriteRecipeListTableViewController = FavoriteRecipeListTableViewController()
    
    static func create(with viewModel:FavoriteRecipeListViewModel,
                       recipeImageRepository:RecipeImageRepository
    ) -> FavoriteRecipeListViewController {
        let vc = FavoriteRecipeListViewController()
        vc.viewModel = viewModel
        vc.recipeImageRepository = recipeImageRepository
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupViews()
        prepareSubViewController()
        setupBehaviours()
        bind(to: viewModel)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        
        let recipeContainer:UIView = {
            let recipeContainer = UIView()
            recipeContainer.translatesAutoresizingMaskIntoConstraints = false
            
            recipeContainer.addSubview(recipeTableController.tableView)
            
            recipeTableController.tableView.leadingAnchor.constraint(equalTo: recipeContainer.leadingAnchor).isActive = true
            recipeTableController.tableView.trailingAnchor.constraint(equalTo: recipeContainer.trailingAnchor).isActive = true
            recipeTableController.tableView.topAnchor.constraint(equalTo: recipeContainer.topAnchor).isActive = true
            recipeTableController.tableView.bottomAnchor.constraint(equalTo: recipeContainer.bottomAnchor).isActive = true
            
            return recipeContainer
        }()
        
        view.addSubview(recipeContainer)

        recipeContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        recipeContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        recipeContainer.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        recipeContainer.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        }
    
    private func prepareSubViewController(){
        addChild(recipeTableController)
        recipeTableController.didMove(toParent: self)
        recipeTableController.viewModel = viewModel
        recipeTableController.recipeImagesRepository = recipeImageRepository
    }
    
    private func bind(to : FavoriteRecipeListViewModel){
        viewModel.recipeItems.observe(on: self) { [weak self] _ in 
            DispatchQueue.main.async{ self?.recipeTableController.reload() }
        }
    }
    
    //공통 컴포넌트에 대한 동작을 처리하기 위해 사용
    private func setupBehaviours() {
        addBehaviors([DefaultNavigationBarBehavior(),
                      ShowTabBarBehavior(),
                      ItemsNavigationBarBehavior(type: .blank_title_blank)])
        
        let titleView = navigationItem.titleView as? UILabel
            titleView?.text = viewModel.title
        
    }
}
