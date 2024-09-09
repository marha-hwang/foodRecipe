//
//  FavoriteFlowCoordinator.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/25.
//

import Foundation
import UIKit

protocol FavoriteRecipeFlowCoordinatorDependencies{
    func makeFavoriteRecipeListViewController(actions:FavoriteRecipeListViewModelActions) -> FavoriteRecipeListViewController
    func makeRecipeDetailViewController(recipe:Recipe) -> RecipeDetailViewController
}

final class FavoriteRecipeFlowCoordinator{
    private weak var navigationController: UINavigationController?
    private let dependencies: FavoriteRecipeFlowCoordinatorDependencies

    private weak var favoriteRecipeListVC: FavoriteRecipeListViewController?

    init(navigationController: UINavigationController,
         dependencies: FavoriteRecipeFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        
       let actions = FavoriteRecipeListViewModelActions(showRecipeDetail: showRecipeDetail(recipe:))
        
        let vc = dependencies.makeFavoriteRecipeListViewController(actions: actions)
        favoriteRecipeListVC = vc
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func showRecipeDetail(recipe:Recipe)->Void{
        let vc = dependencies.makeRecipeDetailViewController(recipe: recipe)
        navigationController?.pushViewController(vc, animated: false)
    }}
