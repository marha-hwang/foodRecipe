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
        
        favoriteView.snp.makeConstraints{ make in
            make.width.equalTo(45.adjustW)
            make.height.equalTo(45.adjustH)
        }
        
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
                    print("status true")
                }
                else{
                    self?.favoriteView.tintColor = .green
                    print("status false")
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
                let outerView = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .center)
                outerView.spacing = 10

                let mainImageView:UIImageView = {
                    let mainImageView = UIImageView()

                    updateImage(url: viewModel.recipe.main_image){ image in
                        mainImageView.image = image
                    }
                    
                    mainImageView.snp.makeConstraints{make in
                        make.height.equalTo(219.adjustH)
                        make.width.equalTo(393.adjustW)
                    }
                    
                    return mainImageView
                }()
                
                
                let mainView:UIStackView = {
                    let mainView = UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .leading)
                    
                    mainView.snp.makeConstraints{ make in
                        make.width.equalTo(360.adjustW)
                    }
                    
                    let leftView:UIStackView = {
                        let leftView = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .center)
                        
                        let title:UILabel = {
                            let title = UILabel()
                            title.text = viewModel.recipe.recipe_name
                            title.font = UIFont.systemFont(ofSize: CGFloat(16))
                            
                            title.sizeToFit()
                            
                            return title
                        }()
                        
                        let subTitle:UILabel = {
                            let subTitle = UILabel()
                            
                            subTitle.text = "\(viewModel.recipe.cookWay) / \(viewModel.recipe.recipe_type)"
                            subTitle.font =  UIFont.systemFont(ofSize: CGFloat(10))
                            
                            subTitle.sizeToFit()
                            subTitle.textAlignment = .left
                            
                            return subTitle
                        }()
                        
                        leftView.addArrangedSubview(title)
                        leftView.addArrangedSubview(subTitle)
                        
                        return leftView
                    }()
                    
                    let rightView:UIStackView = {
                        let rightView = UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .center)
                        
                        rightView.addArrangedSubview(favoriteView)
                        
                        return rightView
                    }()
                    
                    mainView.addArrangedSubview(leftView)
                    mainView.addArrangedSubview(rightView)
                    
                    let line = UIView()
                    mainView.addSubview(line)
                    line.backgroundColor = .black
                    line.snp.makeConstraints{ make in
                        make.leading.bottom.equalToSuperview()
                        make.height.equalTo(1)
                        make.width.equalToSuperview()
                    }
                    
                    return mainView
                } ()
                
                
                let nutritionView = {
                    let nutritionView = UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .leading)
                    
                    mainView.snp.makeConstraints{ make in
                        make.width.equalTo(360.adjustW)
                    }
                    
                    let leftView:UIStackView = {
                        let leftView = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .center)
                        
                        let title:UILabel = {
                            let title = UILabel()
                            title.text = viewModel.recipe.recipe_name
                            title.font = UIFont.systemFont(ofSize: CGFloat(16))
                            
                            title.sizeToFit()
                            
                            return title
                        }()
                        
                        let subTitle:UILabel = {
                            let subTitle = UILabel()
                            
                            subTitle.text = "\(viewModel.recipe.cookWay) / \(viewModel.recipe.recipe_type)"
                            subTitle.font =  UIFont.systemFont(ofSize: CGFloat(10))
                            
                            subTitle.sizeToFit()
                            subTitle.textAlignment = .left
                            
                            return subTitle
                        }()
                        
                        leftView.addArrangedSubview(title)
                        leftView.addArrangedSubview(subTitle)
                        
                        return leftView
                    }()
                    
                    let rightView:UIStackView = {
                        let leftView = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .center)
                        
                        let title:UILabel = {
                            let title = UILabel()
                            title.text = viewModel.recipe.recipe_name
                            title.font = UIFont.systemFont(ofSize: CGFloat(16))
                            
                            title.sizeToFit()
                            
                            return title
                        }()
                        
                        let subTitle:UILabel = {
                            let subTitle = UILabel()
                            
                            subTitle.text = "\(viewModel.recipe.cookWay) / \(viewModel.recipe.recipe_type)"
                            subTitle.font =  UIFont.systemFont(ofSize: CGFloat(10))
                            
                            subTitle.sizeToFit()
                            subTitle.textAlignment = .left
                            
                            return subTitle
                        }()
                        
                        leftView.addArrangedSubview(title)
                        leftView.addArrangedSubview(subTitle)
                        
                        return leftView
                    }()
                    
                    nutritionView.addArrangedSubview(leftView)
                    nutritionView.addArrangedSubview(rightView)
                    
                    let line = UIView()
                    nutritionView.addSubview(line)
                    line.backgroundColor = .black
                    line.snp.makeConstraints{ make in
                        make.leading.bottom.equalToSuperview()
                        make.height.equalTo(1)
                        make.width.equalToSuperview()
                    }
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
                
                nutritionView.snp.makeConstraints{ make in
                    make.width.equalTo(360.adjustW)
                }
                
                
                return outerView
            }()
            
            scrollView.addSubview(outerView)
            
            outerView.snp.makeConstraints{ make in
                make.top.leading.trailing.equalTo(scrollView.contentLayoutGuide)
                make.bottom.equalToSuperview().inset(50)
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
