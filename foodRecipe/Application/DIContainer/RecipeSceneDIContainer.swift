//
//  RecipeSceneDIContainer.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/04.
//

import Foundation
import UIKit

final class RecipeSceneDIContainer:RecipeSearchFlowCoordinatorDependencies{
    func makeRecipeMainViewController() -> RecipeMainViewController {
        RecipeMainViewController.create()
    }
    
    func makeRecipeSearchFlowCoordinator(navigationController: UINavigationController) -> RecipeSearchFlowCoordinator {
        RecipeSearchFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
}
