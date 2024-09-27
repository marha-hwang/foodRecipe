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
        favoriteView.image = UIImage(systemName: "heart")
        favoriteView.tintColor = .red
        
        favoriteView.snp.makeConstraints{ make in
            make.width.equalTo(31.adjustW)
            make.height.equalTo(31.adjustH)
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
                    self?.favoriteView.image = UIImage(systemName: "heart.fill")
                }
                else{
                    self?.favoriteView.image = UIImage(systemName: "heart")
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
                        make.height.equalTo(300.adjustH)
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
                        let leftView = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .leading)
                        
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
                        let rightView = UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .trailing)
                        
                        rightView.addArrangedSubview(favoriteView)
                        
                        return rightView
                    }()
                    
                    mainView.addArrangedSubview(leftView)
                    mainView.addArrangedSubview(rightView)
                    
                    mainView.addBorder([.bottom], width: 1, color: .black)
                    
                    return mainView
                } ()
                
                
                let nutritionView = {
                    let nutritionView = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .leading)
                    
                    let title:UILabel = {
                        let title = UILabel()
                        title.text = "영양정보"
                        title.font = UIFont.systemFont(ofSize: CGFloat(16))
                        
                        title.sizeToFit()
                        
                        return title
                    }()
                    
                    let elementsView:UIStackView = {
                        let elementsView = UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .leading)
                        
                        elementsView.snp.makeConstraints{ make in
                            make.width.equalTo(360.adjustW)
                        }
                        
                        let leftView:UIStackView = {
                            let leftView = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .center)
                            
                            let item1 = makeIngredientItem(key: "중량", value: viewModel.recipe.info_wgt == "" ? "정보없음" : viewModel.recipe.info_wgt)
                            let item2 = makeIngredientItem(key: "탄수화물", value: viewModel.recipe.info_fat == "" ? "정보없음" : viewModel.recipe.info_fat)
                            let item3 = makeIngredientItem(key: "지방", value: viewModel.recipe.info_cal == "" ? "정보없음" : viewModel.recipe.info_cal)

                            leftView.addArrangedSubview(item1)
                            leftView.addArrangedSubview(item2)
                            leftView.addArrangedSubview(item3)
                            
                            return leftView
                        }()
                        
                        let rightView:UIStackView = {
                            let rightView = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .center)
                            
                            let item1 = makeIngredientItem(key: "열량", value: viewModel.recipe.info_eng == "" ? "정보없음" : viewModel.recipe.info_eng)
                            let item2 = makeIngredientItem(key: "단백질", value: viewModel.recipe.info_pro == "" ? "정보없음" : viewModel.recipe.info_pro)
                            let item3 = makeIngredientItem(key: "나트륨", value: viewModel.recipe.info_na == "" ? "정보없음" : viewModel.recipe.info_na)

                            rightView.addArrangedSubview(item1)
                            rightView.addArrangedSubview(item2)
                            rightView.addArrangedSubview(item3)
                            
                            return rightView
                        }() 
                        
                        elementsView.addArrangedSubview(leftView)
                        elementsView.addArrangedSubview(rightView)
                        
                        return elementsView
                    }()
                    
                    
                    nutritionView.addArrangedSubview(title)
                    nutritionView.addArrangedSubview(elementsView)
                    nutritionView.addBorder([.bottom], width: 1, color: .black)
                    return nutritionView
                }()
                
                let ingredientView = {
                    let ingredientView = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .leading)
                    ingredientView.snp.makeConstraints{ make in
                        make.width.equalTo(360.adjustW)
                    }
                    
                    let title:UILabel = {
                        let title = UILabel()
                        title.text = "재료정보"
                        title.font = UIFont.systemFont(ofSize: CGFloat(16))
                        
                        title.sizeToFit()
                        
                        return title
                    }()
                    
                    let content:UILabel = {
                        let content = UILabel()
                        content.text = viewModel.recipe.ingredients
                        content.font = UIFont.systemFont(ofSize: CGFloat(16))
                        
                        content.sizeToFit()
                        
                        return content
                    }()
                    
                    ingredientView.addArrangedSubview(title)
                    ingredientView.addArrangedSubview(content)
                    
                    return ingredientView
                }()
                
                let tipView:UIStackView = {
                    let tipView = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .leading)
                    
                    tipView.snp.makeConstraints{ make in
                        make.width.equalTo(360.adjustW)
                    }
                    tipView.backgroundColor = UIColor(hex: "ECEDE4", alpha: 1.0)
                    tipView.layer.shadowColor = UIColor.black.cgColor
                    tipView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
                    tipView.layer.shadowOpacity = 0.2
                    tipView.layer.shadowRadius = 4.0
                    
                    
                    let title:UILabel = {
                        let title = UILabel()
                        title.text = "조리 Tip!!!"
                        title.font = UIFont.systemFont(ofSize: CGFloat(20))
                        
                        title.sizeToFit()
                        
                        return title
                    }()
                    
                    let tip:UILabel = {
                        let tip = UILabel()
                        tip.text = viewModel.recipe.recipe_tip == "" ? "정보없음" : viewModel.recipe.recipe_tip
                        tip.font = UIFont.systemFont(ofSize: CGFloat(16))
                        tip.numberOfLines = 0
                        
                        tip.sizeToFit()
                        
                        return tip
                    }()
                    
                    tipView.addArrangedSubview(title)
                    tipView.addArrangedSubview(tip)
                    
                    return tipView
                }()
                
                let recipeView = {
                    let recipeView = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .leading)
                    
                    
                    for i in 1...viewModel.recipe.manual.count{
                        
                        if viewModel.recipe.manual[i-1].description == "" { break }
                        
                        let recipeItem = makeRecipeItem(index: i, item: viewModel.recipe.manual[i-1])
                        recipeView.addArrangedSubview(recipeItem)
                    }
                    
                    return recipeView
                }()
                
                outerView.addArrangedSubview(mainImageView)
                outerView.addArrangedSubview(mainView)
                outerView.addArrangedSubview(nutritionView)
                outerView.addArrangedSubview(ingredientView)
                outerView.addArrangedSubview(tipView)
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
    
    private func makeIngredientItem(key:String, value:String)->UIStackView{
        let item = UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .center)
        
        item.snp.makeConstraints{ make in
            make.width.equalTo(134.adjustW)
            make.height.equalTo(18.adjustH)
        }
        
        let label1:UILabel = {
            let label1 = UILabel()
            label1.text = key
            label1.font = UIFont.systemFont(ofSize: CGFloat(16))
            
            label1.sizeToFit()
            
            return label1
        }()
        
        let label2:UILabel = {
            let label2 = UILabel()
            print(viewModel.recipe.info_wgt)
            label2.text = value
            label2.font = UIFont.systemFont(ofSize: CGFloat(16))
            
            label2.sizeToFit()
            
            return label2
        }()
        
        item.addArrangedSubview(label1)
        item.addArrangedSubview(label2)
        item.addBorder([.bottom], width: 1, color: .black)
        
        return item
    }
    
    private func makeRecipeItem(index:Int, item:ManualItem)->UIStackView{
            let recipeItem = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .leading)
            
            recipeItem.snp.makeConstraints{ make in
                make.width.equalTo(360.adjustW)
            }
            
            let stageLabel:UILabel = {
                let stageLabel = UILabel()
                stageLabel.text = "STEP\(index)"
                
                stageLabel.font = UIFont.systemFont(ofSize: CGFloat(16))
                stageLabel.sizeToFit()
                
                return stageLabel
            }()
            
            let stageImage:UIImageView = {
                let stageImage:UIImageView = UIImageView()
                
                stageImage.snp.makeConstraints{ make in
                    make.height.equalTo(180.adjustH)
                    make.width.equalTo(319.adjustW)
                }
                
                updateImage(url: item.imageUrl){ image in
                    stageImage.image = image
                }
                
                return stageImage
            }()
            
            let stageText:UILabel = {
                let stageText = UILabel()
                stageText.text = item.description
                stageText.numberOfLines = 0
                stageText.font = UIFont.systemFont(ofSize: CGFloat(16))
                stageText.sizeToFit()
                
                return stageText
            }()
            
            recipeItem.addArrangedSubview(stageLabel)
            recipeItem.addArrangedSubview(stageImage)
            recipeItem.addArrangedSubview(stageText)
            
            return recipeItem
    }
    
    private func updateImage(url:String, completion:@escaping (UIImage)->Void){
        let _ = recipeImageRepository?.fetchImage(with: url){ result in
            switch result{
            case .success(let data):
                if let image = UIImage(data: data){
                    DispatchQueue.main.async{
                        completion(image)
                    }
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
