//
//  RecipeSceneDIContainer.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/04.
//

import Foundation
import UIKit

final class RecipeSceneDIContainer:RecipeSearchFlowCoordinatorDependencies,FavoriteRecipeFlowCoordinatorDependencies{
    
    //MARK: Persistent Storage
    lazy var recipeQueryStorage = CoreDataRecipeQueryStorage(coreDataStorage: CoreDataStorage.shared)
    
    //MARK: REPOSITORY
    func makeRecipeRepository()->RecipeRepository{
        DefaultRecipeRepository()
    }
    
    func makeRecipeQuriesRepository()->RecipeQueriesRepository{
        DefaultRecipeQueryRepository(recipeQueryStorage: recipeQueryStorage)
    }
    
    //MARK: USECASE
    func makeSearchRecipeUseCase()->SearchRecipeUseCase{
        DefaultSearchRecipeUseCase(recipeRepository: makeRecipeRepository(),
                                   recipeQueryQueriesRepository: makeRecipeQuriesRepository())
    }
    
    //MARK: RecipeMain
    func makeRecipeMainViewController(actions: RecipeMainViewModelActions) -> RecipeMainViewController {
        RecipeMainViewController.create(with: makeRecipeMainViewModel(actions: actions))
    }
    
    func makeRecipeMainViewModel(actions:RecipeMainViewModelActions) -> RecipeMainViewModel{
        DefaultRecipeMainViewModel(searchRecipeUsecase: makeSearchRecipeUseCase(),
                                   actions: actions)
    }
    
    //MARK: FavoriteRecipe
    func makeFavoriteRecipeListViewController() -> FavoriteRecipeListViewController{
        FavoriteRecipeListViewController.create()
    }
    
    func makeRecipeSearchFlowCoordinator(navigationController: UINavigationController) -> RecipeSearchFlowCoordinator {
        RecipeSearchFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
    
    func makeFavoriteRecipeFlowCoordinator(navigationController: UINavigationController) -> FavoriteRecipeFlowCoordinator {
        FavoriteRecipeFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }

}
