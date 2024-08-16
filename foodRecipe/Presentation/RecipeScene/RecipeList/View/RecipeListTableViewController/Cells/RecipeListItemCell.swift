//
//  RecipeListItemCell.swift
//  foodRecipe
//
//  Created by haram on 8/12/24.
//

import Foundation
import UIKit

import UIKit

class RecipeListItemCell:UITableViewCell{
    static let reuseIdentifier = String(describing: RecipeMainItemCell.self)
    private var viewModel: RecipeListItemViewModel!
    private var recipeImageRepository: RecipeImageRepository?
    
    lazy var recipeImage:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    lazy var recipeName:UITextView = {
        let recipeName = UITextView()
        recipeName.translatesAutoresizingMaskIntoConstraints = false
        recipeName.textAlignment = .center
        recipeName.font = UIFont.systemFont(ofSize: 15)
        return recipeName
    }()
    
    lazy var recipeType:UITextView = {
        let recipeType = UITextView()
        recipeType.textAlignment = .center
        recipeType.translatesAutoresizingMaskIntoConstraints = false
        
        return recipeType
    }()
    
    lazy var recipeCategory:UITextView = {
        let recipeCategory = UITextView()
        recipeCategory.textAlignment = .center
        recipeCategory.translatesAutoresizingMaskIntoConstraints = false
 
        return recipeCategory
    }()
    
    lazy var difficultyStar:UIStackView = {
        let difficultyStar = UIStackView()
        difficultyStar.translatesAutoresizingMaskIntoConstraints = false
        difficultyStar.axis = .horizontal
        difficultyStar.alignment = .center
        difficultyStar.distribution = .fillProportionally
        
        
        for i in 0..<5{
            lazy var imageView:UIImageView = {
                let imageView = UIImageView()
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.contentMode = .scaleToFill
                imageView.image = UIImage(systemName: "star")
                imageView.tintColor = .yellow
                
                return imageView
            }()
            
            difficultyStar.addArrangedSubview(imageView)
        }
        
        
        return difficultyStar
    }()
    
    private lazy var outerView:UIStackView = {
        let outerView = UIStackView()
        outerView.axis = .horizontal
        outerView.alignment = .center
        outerView.distribution = .fillProportionally
        outerView.translatesAutoresizingMaskIntoConstraints = false
        
        outerView.layer.masksToBounds = true        
        outerView.layer.cornerRadius = 10
        outerView.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)

        
        lazy var infoStack:UIStackView = {
            let infoStack = UIStackView()
            infoStack.axis = .vertical
            infoStack.alignment = .fill
            infoStack.distribution = .fillProportionally
            
            infoStack.translatesAutoresizingMaskIntoConstraints = false
            infoStack.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
            
            var categoryTypeStack:UIStackView = {
                let categoryTypeStack = UIStackView()
                categoryTypeStack.axis = .horizontal
                categoryTypeStack.alignment = .fill
                categoryTypeStack.distribution = .fillProportionally
                categoryTypeStack.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)

                categoryTypeStack.translatesAutoresizingMaskIntoConstraints = false
                categoryTypeStack.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
                
                categoryTypeStack.addArrangedSubview(recipeType)
                categoryTypeStack.addArrangedSubview(recipeCategory)
                
                recipeType.widthAnchor.constraint(equalTo: categoryTypeStack.widthAnchor, multiplier: 0.5).isActive = true
                recipeCategory.widthAnchor.constraint(equalTo: categoryTypeStack.widthAnchor, multiplier: 0.5).isActive = true

                return categoryTypeStack
            }()
            
            var difficultyStack:UIStackView = {
                let difficultyStack = UIStackView()
                difficultyStack.axis = .horizontal
                difficultyStack.alignment = .fill
                difficultyStack.distribution = .fillProportionally
                difficultyStack.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)

                difficultyStack.translatesAutoresizingMaskIntoConstraints = false
                
                lazy var difficultyLabel:UITextView = {
                    let difficultyLabel = UITextView()
                    difficultyLabel.translatesAutoresizingMaskIntoConstraints = false
                    difficultyLabel.text = "조리 난이도"
                    difficultyLabel.sizeToFit()
                    
                    return difficultyLabel
                }()
                
                difficultyStack.addArrangedSubview(difficultyLabel)
                difficultyStack.addArrangedSubview(difficultyStar)
                
                difficultyLabel.widthAnchor.constraint(equalTo: difficultyStack.widthAnchor, multiplier: 0.4).isActive = true
                difficultyStar.widthAnchor.constraint(equalTo: difficultyStack.widthAnchor, multiplier: 0.6).isActive = true
                
                return difficultyStack
            }()
            
            //추후 요소가 추가될것을 대비하여 생성한 view
            var emptyView:UIView = {
                let emptyView = UIView()
                emptyView.translatesAutoresizingMaskIntoConstraints = false
                return emptyView
            }()
            
            infoStack.addArrangedSubview(recipeName)
            infoStack.addArrangedSubview(categoryTypeStack)
            infoStack.addArrangedSubview(difficultyStack)
            infoStack.addArrangedSubview(emptyView)
            
            recipeName.heightAnchor.constraint(equalTo: infoStack.heightAnchor, multiplier: 0.3).isActive = true
            recipeName.widthAnchor.constraint(equalTo: infoStack.widthAnchor, multiplier: 1).isActive = true

            categoryTypeStack.heightAnchor.constraint(equalTo: infoStack.heightAnchor, multiplier: 0.2).isActive = true
            categoryTypeStack.widthAnchor.constraint(equalTo: infoStack.widthAnchor, multiplier: 1).isActive = true

            difficultyStack.heightAnchor.constraint(equalTo: infoStack.heightAnchor, multiplier: 0.2).isActive = true
            difficultyStack.widthAnchor.constraint(equalTo: infoStack.widthAnchor, multiplier: 1).isActive = true
            
            emptyView.heightAnchor.constraint(equalTo: infoStack.heightAnchor, multiplier: 0.3).isActive = true
            emptyView.widthAnchor.constraint(equalTo: infoStack.widthAnchor, multiplier: 1).isActive = true
            
            return infoStack
        }()
        
        outerView.addArrangedSubview(recipeImage)
        outerView.addArrangedSubview(infoStack)
        
        recipeImage.widthAnchor.constraint(equalTo: outerView.widthAnchor, multiplier: 0.5).isActive = true
        //alignment = fill을 쓰지 않는 경우 높이 제약조건도 추가해야 함
        //multiplier을 통하여 크기 제약조건을 통하여 비율 계산가능
        infoStack.widthAnchor.constraint(equalTo: outerView.widthAnchor, multiplier: 0.5).isActive = true
        infoStack.heightAnchor.constraint(equalTo: outerView.heightAnchor, multiplier: 1).isActive = true
        
        

        return outerView
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func fill(viewModel:RecipeListItemViewModel, recipeImageRepository:RecipeImageRepository?){
        self.viewModel = viewModel
        self.recipeImageRepository = recipeImageRepository
        
        //네크워로로 이미지를 불러와서 이미지를 채워넣어야 함
        updateImage()
        
        self.recipeName.text = viewModel.recipeName
        self.recipeCategory.text = viewModel.recipeCategory
        self.recipeType.text = viewModel.recipeType
        
        //viewModel의 난이도에 따라서 difficultyStar의 별을 그려야함
        for i in 0..<viewModel.difficulty{
            let imageView = difficultyStar.subviews[i] as? UIImageView
            imageView?.image = UIImage(systemName: "star.fill")
        }
    }
    
    private func setupViews(){
        contentView.addSubview(outerView)
        outerView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10).isActive = true
        outerView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        outerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -10).isActive = true
        outerView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    }
    
    private func updateImage(){
        recipeImage.image = nil
        
        let _ = recipeImageRepository?.fetchImage(with: viewModel.imagePath){ [weak self] result in
            
            switch result{
            case .success(let data):
                DispatchQueue.main.async{
                    let image = UIImage(data: data)
                    self?.recipeImage.image = image
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

