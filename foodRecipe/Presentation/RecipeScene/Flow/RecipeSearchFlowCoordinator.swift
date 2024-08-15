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
    func makeRecipeListViewController(listType:RecipeListViewType, title:String, actions:RecipeListViewModelActions) -> RecipeListViewController
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
                                                 showRecipeList: showRecipeList(listType:title:),
                                                 showRecipeDetail: showRecipeDetail(recipe:))
        let vc = dependencies.makeRecipeMainViewController(actions: actions)

        navigationController?.pushViewController(vc, animated: false)
        recipeMainVC = vc
    }
    
    func showRecipeQuriesList()->Void{
        let actions = RecipeQuriesListViewModelActions(showRecipeList: showRecipeList(listType:title:))
        
        let vc = dependencies.makeRecipeQuriesListViewController(actions: actions)
        
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func showRecipeList(listType:RecipeListViewType, title:String)->Void{
        let actions = RecipeListViewModelActions(showRecipeDetail: showRecipeDetail(recipe:), showRecipeQuriesList: showRecipeQuriesList)
        
        //검색화면이 계속 쌓이지 않도록 이전화면이 레시피 리스트 화면과 쿼리리스트 화면인 경우 제거하기 위한 로직
        let vcCount = navigationController!.viewControllers.count
        if vcCount >= 3 {
            let vc1 = navigationController!.viewControllers[vcCount-1] as? RecipeQuriesListViewController
            let vc2 = navigationController!.viewControllers[vcCount-2] as? RecipeListViewController
            let vc3 = navigationController!.viewControllers[vcCount-3] as? RecipeQuriesListViewController
            
            if let _vc1 = vc1, let _ = vc2, let _ = vc3{
                navigationController?.popToViewController(navigationController!.viewControllers[vcCount-4], animated: false)
                navigationController?.pushViewController(_vc1, animated: false)
            }
            
        }
        
        let vc = dependencies.makeRecipeListViewController(listType:listType, title:title, actions:actions)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func showRecipeDetail(recipe:Recipe)->Void{
        let vc = dependencies.makeRecipeDetailViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
}
