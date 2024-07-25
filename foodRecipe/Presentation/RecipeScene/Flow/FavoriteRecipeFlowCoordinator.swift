//
//  FavoriteFlowCoordinator.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/25.
//

import Foundation
import UIKit

protocol FavoriteRecipeFlowCoordinatorDependencies{
    func makeFavoriteRecipeListViewController() -> FavoriteRecipeListViewController 
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
        
        let vc = dependencies.makeFavoriteRecipeListViewController()
        favoriteRecipeListVC = vc
        navigationController?.pushViewController(vc, animated: false)
    }
}
