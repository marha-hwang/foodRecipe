//
//  RecipeQuriesListViewController.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import UIKit

class RecipeQuriesListViewController: UIViewController{

    lazy var quriesController:RecipeQuriesListTableViewController = RecipeQuriesListTableViewController()
    
    private var viewModel: RecipeQuriesListViewModel!
    
    static func create(with viewModel:RecipeQuriesListViewModel) -> RecipeQuriesListViewController {
        let vc = RecipeQuriesListViewController()
        vc.viewModel = viewModel
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
        
        lazy var quriesContainer:UIView = {
            let quriesContainer = UIView()
            quriesContainer.translatesAutoresizingMaskIntoConstraints = false
            
            quriesContainer.addSubview(quriesController.tableView)
            
            quriesController.tableView.leadingAnchor.constraint(equalTo: quriesContainer.leadingAnchor).isActive = true
            quriesController.tableView.trailingAnchor.constraint(equalTo: quriesContainer.trailingAnchor).isActive = true
            quriesController.tableView.topAnchor.constraint(equalTo: quriesContainer.topAnchor).isActive = true
            quriesController.tableView.bottomAnchor.constraint(equalTo: quriesContainer.bottomAnchor).isActive = true
            
            return quriesContainer
        }()
        
        view.addSubview(quriesContainer)
        
        quriesContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        quriesContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
        quriesContainer.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        quriesContainer.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true

        
    }
    
    private func prepareSubViewController(){
        addChild(quriesController)
        quriesController.didMove(toParent: self)
        quriesController.viewModel = viewModel
    }
    
    private func bind(to : RecipeQuriesListViewModel){
        viewModel.quriesItems.observe(on: self) { [weak self] _ in self?.quriesController.reload() }
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
