//
//  AppDelegate.swift
//  foodRecipe
//
//  Created by haram on 6/15/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let appDIContainer = AppDIContainer()
    var appFlowCoordinator: AppFlowCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()

        window?.rootViewController = navigationController
        appFlowCoordinator = AppFlowCoordinator(navigationController: navigationController,
                                                appDIContainer: appDIContainer)
        
        appFlowCoordinator?.start()
        window?.makeKeyAndVisible()
        
        return true
    }
}

