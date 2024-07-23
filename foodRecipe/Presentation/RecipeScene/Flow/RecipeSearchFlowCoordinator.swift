//
//  RecipeSearchFlowCoordinator.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation
import UIKit

protocol RecipeSearchFlowCoordinatorDependencies  {
    func makeRecipeMainViewController(actions: RecipeMainViewModelActions
    ) -> RecipeMainViewController
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
                                                 showRecipeListByKeyword: showRecipeListByKeyword(keyword:),
                                                 showRecipeListByCategory: showRecipeListByCategory(category:),
                                                 showRecipeDetail: showRecipeDetail(recipe:))
        let vc = dependencies.makeRecipeMainViewController(actions: actions)

        navigationController?.pushViewController(vc, animated: false)
        recipeMainVC = vc
    }
    
    func showRecipeQuriesList()->Void{
        
    }
    func showRecipeListByKeyword(keyword:String)->Void{
        
    }
    func showRecipeListByCategory(category:String)->Void{
        
    }
    func showRecipeDetail(recipe:Recipe)->Void{
        
    }
}
