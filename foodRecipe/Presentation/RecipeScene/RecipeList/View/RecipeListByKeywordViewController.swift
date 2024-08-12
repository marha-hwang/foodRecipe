//
//  RecipeListByKeywordViewController.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/22.
//


import UIKit

class RecipeListByKeywordViewController: UIViewController{
        
    private var viewModel: RecipeListViewModel!
    private var recipeImageRepository: RecipeImageRepository?
    
    lazy var recipeTableController:RecipeListTableViewController = RecipeListTableViewController()
    
    static func create(with viewModel:RecipeListViewModel,
                       recipeImageRepository:RecipeImageRepository
    ) -> RecipeListByKeywordViewController {
        let vc = RecipeListByKeywordViewController()
        vc.viewModel = viewModel
        vc.recipeImageRepository = recipeImageRepository
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupViews()
        prepareSubViewController()
        setupBehaviours()
        bind(to: viewModel)
    }
    
    private func setupViews(){
        view.backgroundColor = .white
    
        let recipeContainer:UIView = {
            let recipeContainer = UIView()
            recipeContainer.translatesAutoresizingMaskIntoConstraints = false
            
            recipeContainer.addSubview(recipeTableController.tableView)
            
            recipeTableController.tableView.leadingAnchor.constraint(equalTo: recipeContainer.leadingAnchor).isActive = true
            recipeTableController.tableView.trailingAnchor.constraint(equalTo: recipeContainer.trailingAnchor).isActive = true
            recipeTableController.tableView.topAnchor.constraint(equalTo: recipeContainer.topAnchor).isActive = true
            recipeTableController.tableView.bottomAnchor.constraint(equalTo: recipeContainer.bottomAnchor).isActive = true
            
            return recipeContainer
        }()
        
        view.addSubview(recipeContainer)
        
        recipeContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        recipeContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        recipeContainer.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        recipeContainer.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true

        
    }
    
    private func prepareSubViewController(){
        addChild(recipeTableController)
        recipeTableController.didMove(toParent: self)
        recipeTableController.viewModel = viewModel
    }
    
    private func bind(to : RecipeListViewModel){
        //viewModel.quriesItems.observe(on: self) { [weak self] _ in self?.quriesController.reload() }
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
        //viewModel.didSearchByButton(query: query == "" ? "전체":query)
    }
    
    
}
