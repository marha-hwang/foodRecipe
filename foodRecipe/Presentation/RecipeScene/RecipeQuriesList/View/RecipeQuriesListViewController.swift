//
//  RecipeQuriesListViewController.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import UIKit

class RecipeQuriesListViewController: UIViewController{
    private var viewModel: RecipeQuriesListViewModel!
    
    static func create() -> RecipeQuriesListViewController {
        let vc = RecipeQuriesListViewController()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        setupBehaviours()
    }
    
    //공통 컴포넌트에 대한 동작을 처리하기 위해 사용
    private func setupBehaviours() {
        addBehaviors([DefaultNavigationBarBehavior(),
                     HideTabBarBehavior(),
                      ItemsNavigationBarBehavior(type: .back_searchBar_serchButton)])
    
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(searchButtonEvent))
        navigationItem.titleView?.isUserInteractionEnabled = true
        navigationItem.titleView?.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func searchButtonEvent(sender: UITapGestureRecognizer){
       ///레시피 검색을 여러번 하는 경우 검색화면이 계속 중첩되지 않도록 해야 함
        ///검색기록테이블과 검색결과 테이블이 교체되는 식으로 구현해야 함
        viewModel.showRecipeQuriesList()
    }
    
    
}
