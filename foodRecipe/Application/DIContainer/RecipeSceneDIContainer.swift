//
//  RecipeSceneDIContainer.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/04.
//

import Foundation
import UIKit

final class RecipeSceneDIContainer:RecipeSearchFlowCoordinatorDependencies,FavoriteRecipeFlowCoordinatorDependencies{
    
    //MARK: Cache
    lazy var recipeImageCache = RecipeImageCache.shared
    
    //MARK: Persistent Storage
    lazy var recipeQueryStorage = CoreDataRecipeQueryStorage(coreDataStorage: CoreDataStorage.shared)
    lazy var recipeImageStorage = CoreDataRecipeImageStorage(coreDataStorage: CoreDataStorage.shared)
    
    //MARK: REPOSITORY
    func makeRecipeRepository()->RecipeRepository{
        DefaultRecipeRepository()
    }
    
    func makeRecipeQuriesRepository()->RecipeQueriesRepository{
        DefaultRecipeQueryRepository(recipeQueryStorage: recipeQueryStorage)
    }
    
    func makeRecipeImageRepository()->RecipeImageRepository{
        DefaultRecipeImagesRepository(recipeImageStorage:recipeImageStorage, recipeImageCache:recipeImageCache)
    }
    
    //MARK: USECASE
    func makeSearchRecipeUseCase()->SearchRecipeUseCase{
        DefaultSearchRecipeUseCase(recipeRepository: makeRecipeRepository(),
                                   recipeQueryQueriesRepository: makeRecipeQuriesRepository())
    }
    
    func makeFetchRecentRecipeQuriesUseCase()->FetchRecentRecipeQuriesUseCase{
        DefaultFetchRecentRecipeQueriesUseCase(recipeQueriesRepository: makeRecipeQuriesRepository())
    }
    
    func makeRemoveRecentRecipeQuriesUseCase()->RemoveRecentRecipeQuriesUseCase{
        DefaultRemoveRecentRecipeQuriesUseCase(recipeQueriesRepository: makeRecipeQuriesRepository())
    }
    
    //MARK: RecipeMain
    func makeRecipeMainViewController(actions: RecipeMainViewModelActions) -> RecipeMainViewController {
        RecipeMainViewController.create(with: makeRecipeMainViewModel(actions: actions), recipeImageRepository: makeRecipeImageRepository())
    }
    
    func makeRecipeMainViewModel(actions:RecipeMainViewModelActions) -> RecipeMainViewModel{
        DefaultRecipeMainViewModel(searchRecipeUsecase: makeSearchRecipeUseCase(),
                                   actions: actions)
    }
    
    //MARK: RecipeQuriesList
    func makeRecipeQuriesListViewController(actions: RecipeQuriesListViewModelActions) -> RecipeQuriesListViewController {
        RecipeQuriesListViewController.create(with: makeRecipeQuriesListViewModel(actions: actions))
    }
    
    func makeRecipeQuriesListViewModel(actions:RecipeQuriesListViewModelActions) -> RecipeQuriesListViewModel{
        DefaultRecipeQuriesListViewModel(fetchQuriesUseCase: makeFetchRecentRecipeQuriesUseCase(),
                                         removeQuriesUseCase: makeRemoveRecentRecipeQuriesUseCase(),
                                         actions: actions)
    }
    
    //MARK: RecipeList
    func makeRecipeListViewController(listType:RecipeListViewType, title:String, actions:RecipeListViewModelActions) -> RecipeListViewController {
        let viewModel = makeRecipeListViewModel(actions: actions, listType: listType, title: title)
        return RecipeListViewController.create(with: viewModel,
                                        recipeImageRepository: makeRecipeImageRepository())
    }
    
    func makeRecipeListViewModel(actions:RecipeListViewModelActions, listType:RecipeListViewType, title:String)->RecipeListViewModel{
        DefaultRecipeListViewModel(listType: listType,
                                   title: title,
                                   searchRecipeUseCase: makeSearchRecipeUseCase(),
                                   actions: actions)
    }
    
    //MARK: RecipeDetail
    func makeRecipeDetailViewController() -> RecipeDetailViewController {
        RecipeDetailViewController.create()
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
