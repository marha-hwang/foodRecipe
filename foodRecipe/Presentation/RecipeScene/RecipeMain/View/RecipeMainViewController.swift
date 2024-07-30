//
//  ViewController.swift
//  foodRecipe
//
//  Created by haram on 6/15/24.
//

import UIKit

class RecipeMainViewController: UIViewController{
    private var viewModel: RecipeMainViewModel!
    private var recipeImageRepository: RecipeImageRepository?
    private var recipeMainView:RecipeMainView!
    
    static func create(with viewModel: RecipeMainViewModel, recipeImageRepository:RecipeImageRepository) -> RecipeMainViewController {
        let vc = RecipeMainViewController()
        vc.viewModel = viewModel
        vc.recipeImageRepository = recipeImageRepository
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        prepareSubVC()
        setupBehaviours()
        bind(to: viewModel)
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
        let weatherRecommandGesture = UITapGestureRecognizer(target: self, action: #selector(showCategory))
        recipeMainView.weatherRecommandView.imageView.isUserInteractionEnabled = true
        recipeMainView.weatherRecommandView.imageView.addGestureRecognizer(weatherRecommandGesture)
        
        recipeMainView.timeRecommandView.titleView.text = viewModel.timeRecommandTitle
        let timeRecommandGesture = UITapGestureRecognizer(target: self, action: #selector(showCategory))
        recipeMainView.timeRecommandView.imageView.isUserInteractionEnabled = true
        recipeMainView.timeRecommandView.imageView.addGestureRecognizer(timeRecommandGesture)
    }
    
    private func bind(to viewModel: RecipeMainViewModel) {
        viewModel.weatherRecommandItems.observe(on: self) { [weak self] _ in
            self?.recipeMainView.weatherRecommandView.recipeController.items = viewModel.weatherRecommandItems.value
            self?.recipeMainView.weatherRecommandView.recipeController.reload()
        }
        
        viewModel.timeRecommandItems.observe(on: self) { [weak self] _ in
            self?.recipeMainView.timeRecommandView.recipeController.items = viewModel.timeRecommandItems.value
            self?.recipeMainView.timeRecommandView.recipeController.reload()
        }

    }
    
    private func prepareSubVC(){
        addChild(recipeMainView.weatherRecommandView.recipeController)
        recipeMainView.weatherRecommandView.recipeController.didMove(toParent: self)
        recipeMainView.weatherRecommandView.recipeController.viewModel = viewModel
        recipeMainView.weatherRecommandView.recipeController.recipeImagesRepository = recipeImageRepository
        
        addChild(recipeMainView.timeRecommandView.recipeController)
        recipeMainView.timeRecommandView.recipeController.didMove(toParent: self)
        recipeMainView.timeRecommandView.recipeController.viewModel = viewModel
        recipeMainView.timeRecommandView.recipeController.recipeImagesRepository = recipeImageRepository
    }
    
    //공통 컴포넌트에 대한 동작을 처리하기 위해 사용
    private func setupBehaviours() {
        addBehaviors([DefaultNavigationBarBehavior(),
                     DefaultTabBarBehavior(),
                      ItemsNavigationBarBehavior(type: .logo_searchAreaButton_blank)])
    
        //addBehaviors는 UI공통 컴포넌트만 생성하는 역활이기 때문에, 화면정보,이벤트를 커스텀하기 위해 코드를 추가해야함
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(searchLabelEvent))
        navigationItem.titleView?.isUserInteractionEnabled = true
        navigationItem.titleView?.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func searchLabelEvent(sender: UITapGestureRecognizer){
        viewModel.showRecipeQuriesList()
    }
    @objc private func showCategory(sender: UITapGestureRecognizer){
        viewModel.showRecipeListByCategory(category: "" )
    }
        
}

