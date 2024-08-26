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
        viewModel.viewDidLoad()
        setupViews()
        prepareSubViewController()
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
        
        recipeMainView.firstRecommandView.titleView.text = viewModel.firsteRcommandTitle
        let weatherRecommandGesture = UITapGestureRecognizer(target: self, action: #selector(showCategory))
        recipeMainView.firstRecommandView.imageView.isUserInteractionEnabled = true
        recipeMainView.firstRecommandView.imageView.addGestureRecognizer(weatherRecommandGesture)
        
        recipeMainView.secondRecommandView.titleView.text = viewModel.secondRecommandTitle
        let timeRecommandGesture = UITapGestureRecognizer(target: self, action: #selector(showCategory))
        recipeMainView.secondRecommandView.imageView.isUserInteractionEnabled = true
        recipeMainView.secondRecommandView.imageView.addGestureRecognizer(timeRecommandGesture)
    }
    
    private func bind(to viewModel: RecipeMainViewModel) {
        viewModel.firstRecommandItems.observe(on: self) { [weak self] _ in
            self?.recipeMainView.firstRecommandView.recipeController.items = viewModel.firstRecommandItems.value
            self?.recipeMainView.firstRecommandView.recipeController.reload()
        }
        
        viewModel.secondRecommandItems.observe(on: self) { [weak self] _ in
            self?.recipeMainView.secondRecommandView.recipeController.items = viewModel.secondRecommandItems.value
            self?.recipeMainView.secondRecommandView.recipeController.reload()
        }

    }
    
    private func prepareSubViewController(){
        addChild(recipeMainView.firstRecommandView.recipeController)
        recipeMainView.firstRecommandView.recipeController.didMove(toParent: self)
        recipeMainView.firstRecommandView.recipeController.viewModel = viewModel
        recipeMainView.firstRecommandView.recipeController.recipeImagesRepository = recipeImageRepository
        
        addChild(recipeMainView.secondRecommandView.recipeController)
        recipeMainView.secondRecommandView.recipeController.didMove(toParent: self)
        recipeMainView.secondRecommandView.recipeController.viewModel = viewModel
        recipeMainView.secondRecommandView.recipeController.recipeImagesRepository = recipeImageRepository
    }
    
    //공통 컴포넌트에 대한 동작을 처리하기 위해 사용
    private func setupBehaviours() {
        addBehaviors([DefaultNavigationBarBehavior(),
                     ShowTabBarBehavior(),
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

