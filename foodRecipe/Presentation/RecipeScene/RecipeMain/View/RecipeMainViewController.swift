//
//  ViewController.swift
//  foodRecipe
//
//  Created by haram on 6/15/24.
//

import UIKit

class RecipeMainViewController: UIViewController{
    private var viewModel: RecipeMainViewModel!
    private var recipeMainView:RecipeMainView!
    private var recipeMainCollectionViewController: RecipeMainCollectionViewController?
    
    static func create(with viewModel: RecipeMainViewModel) -> RecipeMainViewController {
        let vc = RecipeMainViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBehaviours()
    }
    
    private func setupViews(){   
        view.backgroundColor = .white
        recipeMainView = RecipeMainView(frame: CGRect(x: 0, y: 0,
                                                      width: view.safeAreaLayoutGuide.layoutFrame.width,
                                                      height: 0))
        view.addSubview(recipeMainView)
        recipeMainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        recipeMainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        recipeMainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        recipeMainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        recipeMainView.categoryView.backgroundColor = .white
        recipeMainView.categoryView.initForderView(items: viewModel.categoryItems, defaultRow: 2, col: 5){ [weak self] gesture in
            self?.viewModel.showRecipeListByCategory(category: gesture.name ?? "")
        }
        
        recipeMainView.weatherRecommandView.titleView.text = viewModel.weatherRecommandTitle.value
        recipeMainView.timeRecommandView.titleView.text = viewModel.timeRecommandTitle
        
        addChild(recipeMainView.weatherRecommandView.recipeController)
        recipeMainView.weatherRecommandView.recipeController.didMove(toParent: self)
        
        addChild(recipeMainView.timeRecommandView.recipeController)
        recipeMainView.timeRecommandView.recipeController.didMove(toParent: self)
    }
    //공통 컴포넌트에 대한 동작을 처리하기 위해 사용
    private func setupBehaviours() {
        addBehaviors([DefaultNavigationBarBehavior(),
                     DefaultTabBarBehavior(),
                      ItemsNavigationBarBehavior(items: Items(left: .logo,
                                                                 center: .searchAreaButton,
                                                                 right: .blank))])
    }
        
}

