//
//  RecipeSearchFlowCoordinator.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation
import UIKit

protocol RecipeSearchFlowCoordinatorDependencies  {
    func makeRecipeListViewController(
    ) -> RecipeListViewController
}

final class RecipeSearchFlowCoordinator{
    private weak var navigationController: UINavigationController?
    private let dependencies: RecipeSearchFlowCoordinatorDependencies

    private weak var recipeListVC: RecipeListViewController?

    init(navigationController: UINavigationController,
         dependencies: RecipeSearchFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let vc = dependencies.makeRecipeListViewController()

        navigationController?.pushViewController(vc, animated: false)
        recipeListVC = vc
    }
}
