//
//  AppFlowCoordinator.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/04.
//

import Foundation
import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(
        navigationController: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let isLogin = true
        
        //만약 로그인을 해야하는 경우 LoginScene으로 이동
        if !isLogin{
            moveLogin()
        }
        //로그인 할 필요가 업는 경우 메인화면으로 이동
        else {
            moveMain()
        }
    }
    
    private func moveLogin(){
        
    }
    
    private func moveMain(){
        navigationController.isNavigationBarHidden = true
        
        let searchNav = UINavigationController()
        let favoriteNav = UINavigationController()
        
        let tabbar = CustomTabBarController()
        tabbar.setViewControllers([searchNav, favoriteNav], animated: false)
        searchNav.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "menucard"), selectedImage: UIImage(systemName: "menucard.fill"))
        
        favoriteNav.tabBarItem = UITabBarItem(title: "즐겨찾기", image: UIImage(systemName: "bookmark"), selectedImage: UIImage(systemName: "bookmark.fill"))       
        
        navigationController.pushViewController(tabbar, animated: false)
        
        
        let recipeSceneDIContainer = appDIContainer.makeRecipeSceneDIContainer()
        
        let searchFlow = recipeSceneDIContainer.makeRecipeSearchFlowCoordinator(navigationController: searchNav)
        searchFlow.start()
        
        let favoriteFlow = recipeSceneDIContainer.makeFavoriteRecipeFlowCoordinator(navigationController: favoriteNav)
        favoriteFlow.start()
    }
}
