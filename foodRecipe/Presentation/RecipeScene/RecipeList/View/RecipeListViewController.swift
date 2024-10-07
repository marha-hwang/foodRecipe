//
//  RecipeListByKeywordViewController.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/22.
//


import UIKit

class RecipeListViewController: UIViewController{
        
    private var viewModel: RecipeListViewModel!
    private var recipeImageRepository: RecipeImageRepository?
    
    lazy var recipeTableController:RecipeListTableViewController = RecipeListTableViewController()
    
    static func create(with viewModel:RecipeListViewModel,
                       recipeImageRepository:RecipeImageRepository
    ) -> RecipeListViewController {
        let vc = RecipeListViewController()
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
    
        let categoryScrollView: UIScrollView = {
            let categoryScrollView = UIScrollView()
            categoryScrollView.translatesAutoresizingMaskIntoConstraints = false
            categoryScrollView.showsHorizontalScrollIndicator = false
            
            
            //추후 스택뷰를 상속받은 카테고리 스택뷰를 구현하여 아이템들을 공통으로 관리하기 위한 이벤트 추가해야함
            let categoryStackView:UIStackView = {
                let categoryStackView = UIStackView()
                categoryStackView.axis = .horizontal
                categoryStackView.alignment = .center
                categoryStackView.translatesAutoresizingMaskIntoConstraints = false
                
                addCategoryItems(view: categoryStackView, items: viewModel.categoryItems)
                
                return categoryStackView
            }()
            
            categoryScrollView.addSubview(categoryStackView)
            categoryStackView.addBorder([.bottom], width: 1, color: .gray)
            categoryStackView.topAnchor.constraint(equalTo: categoryScrollView.contentLayoutGuide.topAnchor).isActive = true
            categoryStackView.bottomAnchor.constraint(equalTo: categoryScrollView.contentLayoutGuide.bottomAnchor).isActive = true
            categoryStackView.trailingAnchor.constraint(equalTo: categoryScrollView.contentLayoutGuide.trailingAnchor).isActive = true
            categoryStackView.leadingAnchor.constraint(equalTo: categoryScrollView.contentLayoutGuide.leadingAnchor).isActive = true
            
            
            return categoryScrollView
        }()
        
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
        
        view.addSubview(categoryScrollView)
        view.addSubview(recipeContainer)
        
        categoryScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        categoryScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        categoryScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        categoryScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        
        recipeContainer.topAnchor.constraint(equalTo: categoryScrollView.bottomAnchor).isActive = true
        recipeContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
        recipeContainer.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        recipeContainer.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        
        //검색어를 통한 리스트인 경우 카테고리 스크롤바 안보이도록 하기 위함
        if viewModel.listType == .byKeyword {
            categoryScrollView.isHidden = true
            categoryScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true

        }
    }
    
    private func prepareSubViewController(){
        addChild(recipeTableController)
        recipeTableController.didMove(toParent: self)
        recipeTableController.viewModel = viewModel
        recipeTableController.recipeImagesRepository = recipeImageRepository
    }
    
    private func bind(to : RecipeListViewModel){
        viewModel.recipeItems.observe(on: self) { [weak self] _ in self?.recipeTableController.reload() }
        viewModel.title.observe(on: self) { [weak self] _ in
            let titleView = self?.navigationItem.titleView as? UILabel
            titleView?.text = self?.viewModel.title.value
        }
        viewModel.loading.observe(on: self){ [weak self] _ in
            
            DispatchQueue.main.async{
                if self?.viewModel.loading.value == true{
                    LoadingIndicator.showLoading()
                }
                else if self?.viewModel.loading.value == false{
                    LoadingIndicator.hideLoading()
                }
            }
        }
    }
    
    //공통 컴포넌트에 대한 동작을 처리하기 위해 사용
    private func setupBehaviours() {
        addBehaviors([DefaultNavigationBarBehavior(),
                     HideTabBarBehavior(),
                      ItemsNavigationBarBehavior(type: .back_searchTitle_searchBtn)])
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(searchButtonEvent))
        let rightItem = navigationItem.rightBarButtonItem
        rightItem?.isEnabled = true
        rightItem?.customView?.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func searchButtonEvent(sender: UITapGestureRecognizer){
        viewModel.didTouchSearchButton()
    }
    
    private func addCategoryItems(view:UIStackView, items:[String]){
        let width = items.count * 100
        
        view.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
        
        for i in 0..<items.count{
            let label = UILabel()
            label.widthAnchor.constraint(equalToConstant: 100).isActive = true
            label.heightAnchor.constraint(equalToConstant: 50).isActive = true
            label.text = items[i]
            label.textAlignment = .center
            view.addArrangedSubview(label)
            
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tabCategoryEvent))
            gestureRecognizer.name = items[i]
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(gestureRecognizer)

        }
    }
    
    @objc private func tabCategoryEvent(sender: UITapGestureRecognizer){
        guard let name = sender.name else {
            return
        }
        viewModel.didTouchCategory(category: name)
    }

    
    
}
