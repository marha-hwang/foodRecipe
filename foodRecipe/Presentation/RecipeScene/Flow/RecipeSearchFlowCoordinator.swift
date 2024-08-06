//
//  RecipeSearchFlowCoordinator.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation
import UIKit

protocol RecipeSearchFlowCoordinatorDependencies  {
    func makeRecipeMainViewController(actions: RecipeMainViewModelActions) -> RecipeMainViewController
    func makeRecipeQuriesListViewController(actions:RecipeQuriesListViewModelActions) -> RecipeQuriesListViewController
    func makeRecipeListByKeywordViewController(keyword:String) -> RecipeListByKeywordViewController
    func makeRecipeListByCategoryViewController() -> RecipeListByCategoryViewController
    func makeRecipeDetailViewController() -> RecipeDetailViewController
}

final class RecipeSearchFlowCoordinator{
    private weak var navigationController: UINavigationController?
    private let dependencies: RecipeSearchFlowCoordinatorDependencies

    private weak var recipeMainVC: RecipeMainViewController?

    init(navigationController: UINavigationController,
         dependencies: RecipeSearchFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = RecipeMainViewModelActions(showRecipeQuriesList: showRecipeQuriesList,
                                                 showRecipeListByCategory: showRecipeListByCategory(category:),
                                                 showRecipeDetail: showRecipeDetail(recipe:))
        let vc = dependencies.makeRecipeMainViewController(actions: actions)

        navigationController?.pushViewController(vc, animated: false)
        recipeMainVC = vc
    }
    
    func showRecipeQuriesList()->Void{
        let actions = RecipeQuriesListViewModelActions(showRecipeListByKeyword: showRecipeListByKeyword(keyword:))
        
        let vc = dependencies.makeRecipeQuriesListViewController(actions: actions)
        
        //검색화면이 계속 쌓이지 않도록 이전화면이 키워드검색화면이라면 키워드검색화면과 쿼리리스트 화면 제거해야함
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func showRecipeListByKeyword(keyword:String)->Void{
        let vc = dependencies.makeRecipeListByKeywordViewController(keyword: keyword)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func showRecipeListByCategory(category:String)->Void{
        let vc = dependencies.makeRecipeListByCategoryViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func showRecipeDetail(recipe:Recipe)->Void{
        let vc = dependencies.makeRecipeDetailViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
}
