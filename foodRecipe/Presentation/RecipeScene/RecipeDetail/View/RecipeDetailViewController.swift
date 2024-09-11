//
//  RecipeDetailViewController.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import UIKit
import SnapKit

class RecipeDetailViewController: UIViewController{
    private var viewModel: RecipeDetailViewModel!
    private var recipeImageRepository:RecipeImageRepository?
    
    private lazy var favoriteView:UIImageView = {
        let favoriteView = UIImageView()
        favoriteView.contentMode = .scaleToFill
        favoriteView.image = UIImage(systemName: "star")
        favoriteView.tintColor = .gray
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(favoriteChangeEvent))
        favoriteView.isUserInteractionEnabled = true
        favoriteView.addGestureRecognizer(gestureRecognizer)
        
        return favoriteView
    }()
    
    static func create(with viewModel:RecipeDetailViewModel,
                       recipeImageRepository:RecipeImageRepository
    ) -> RecipeDetailViewController {
        let vc = RecipeDetailViewController()
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
    
    private func bind(to viewModel: RecipeDetailViewModel){
        viewModel.favoriteStatus.observe(on: self){[weak self] _ in
            print("Status Changed")
            DispatchQueue.main.async{
                if self?.viewModel.favoriteStatus.value == true{
                    self?.favoriteView.tintColor = .yellow
                }
                else{
                    self?.favoriteView.tintColor = .green
                }
                
            }
        }

    }
    
    private func prepareSubViewController(){
        
    }
    
    private func setupBehaviours(){
        addBehaviors([DefaultNavigationBarBehavior(),
                      ItemsNavigationBarBehavior(type: .blank_title_blank),
                      HideTabBarBehavior(),
                     ])
        
        let titleView = navigationItem.titleView as? UILabel
        titleView?.text = viewModel.recipe.recipe_name
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        let scrollView:UIScrollView = {
            let scrollView = UIScrollView()
            
            let outerView:UIStackView = {
                let outerView = UIStackView()
                outerView.axis = .vertical
                outerView.alignment = .fill
                outerView.distribution = .fillProportionally
                
                let mainImageView:UIImageView = {
                    let mainImageView = UIImageView()
                    
                    updateImage(url: viewModel.recipe.main_image){ image in
                        mainImageView.image = image
                    }
                    
                    return mainImageView
                }()
                
                let mainView:UIView = {
                    let mainView = UIView()
                    mainView.backgroundColor = .cyan
                    
                    let title:UILabel = {
                       let title = UILabel()
                        
                        title.text = viewModel.recipe.recipe_name
                        
                        return title
                    }()
                    
                    let subTitle:UILabel = {
                        let subTitle = UILabel()
                        
                        subTitle.text = "\(viewModel.recipe.cookWay) / \(viewModel.recipe.recipe_type)"
                        return subTitle
                    }()
                    
                    mainView.addSubview(title)
                    mainView.addSubview(subTitle)
                    mainView.addSubview(favoriteView)
                    
                    title.snp.makeConstraints{ make in
                        make.top.leading.equalToSuperview().inset(20)
                    }
                    
                    subTitle.snp.makeConstraints{ make in
                        make.leading.equalToSuperview().inset(20)
                        make.top.equalTo(title.snp.bottom)
                    }
                    
                    favoriteView.snp.makeConstraints{ make in
                        make.width.height.equalTo(40)
                        make.trailing.equalToSuperview().inset(20)
                        make.top.equalToSuperview().inset(20)
                    }
                    
                    return mainView
                } ()
                
                let nutritionView = {
                    let nutritionView = UIStackView()
                    nutritionView.backgroundColor = .gray
                    return nutritionView
                }()
                
                let ingredientView = {
                    let ingredientView = UIStackView()
                    ingredientView.backgroundColor = .green
                    return ingredientView
                }()
                
                let recipeView = {
                    let recipeView = UIStackView()
                    ingredientView.backgroundColor = .magenta
                    return recipeView
                }()
                
                outerView.addArrangedSubview(mainImageView)
                outerView.addArrangedSubview(mainView)
                outerView.addArrangedSubview(nutritionView)
                outerView.addArrangedSubview(ingredientView)
                outerView.addArrangedSubview(recipeView)
                
                mainImageView.snp.makeConstraints{ make in
                    make.height.equalTo(200)
                }
                
                
                return outerView
            }()
            
            scrollView.addSubview(outerView)
            
            outerView.snp.makeConstraints{ make in
                make.top.leading.trailing.equalTo(scrollView.contentLayoutGuide)
                make.bottom.equalToSuperview().inset(50)
                make.width.equalToSuperview()
            }
            
            return scrollView
        }()
        
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints{ make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func updateImage(url:String, completion:@escaping (UIImage)->Void){
        let _ = recipeImageRepository?.fetchImage(with: url){ result in
            switch result{
            case .success(let data):
                if let image = UIImage(data: data){
                    completion(image)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc private func favoriteChangeEvent(sender: UITapGestureRecognizer){
        viewModel.didTouchFavorite()
    }

}
