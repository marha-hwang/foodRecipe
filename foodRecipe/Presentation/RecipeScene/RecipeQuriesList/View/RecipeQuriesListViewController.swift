//
//  RecipeQuriesListViewController.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import UIKit

class RecipeQuriesListViewController: UIViewController{
    private var viewModel: RecipeQuriesListViewModel!
    
    static func create(with viewModel:RecipeQuriesListViewModel) -> RecipeQuriesListViewController {
        let vc = RecipeQuriesListViewController()
        vc.viewModel = viewModel
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
        
        let rightItem = navigationItem.rightBarButtonItem
        rightItem?.isEnabled = true
        rightItem?.customView?.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func searchButtonEvent(sender: UITapGestureRecognizer){
        let searchBar = navigationItem.titleView as? UISearchBar
        let query = searchBar?.text ?? "전체"
        viewModel.didSearchByButton(query: query == "" ? "전체":query)
    }
    
    
}
