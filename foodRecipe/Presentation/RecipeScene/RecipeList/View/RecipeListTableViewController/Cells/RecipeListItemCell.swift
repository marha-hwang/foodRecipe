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
        
        return recipeName
    }()
    
    lazy var recipeType:UITextView = {
        let recipeType = UITextView()
        recipeType.translatesAutoresizingMaskIntoConstraints = false
        
        return recipeType
    }()
    
    lazy var recipeCategory:UITextView = {
        let recipeCategory = UITextView()
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
        
        lazy var infoStack:UIStackView = {
            let infoStack = UIStackView()
            infoStack.axis = .vertical
            infoStack.alignment = .center
            infoStack.distribution = .fillProportionally
            
            infoStack.translatesAutoresizingMaskIntoConstraints = false
            infoStack.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
            
            var categoryTypeStack:UIStackView = {
                let categoryTypeStack = UIStackView()
                categoryTypeStack.axis = .horizontal
                categoryTypeStack.alignment = .center
                categoryTypeStack.distribution = .fillProportionally
                
                categoryTypeStack.translatesAutoresizingMaskIntoConstraints = false
                categoryTypeStack.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
                
                categoryTypeStack.addArrangedSubview(recipeType)
                categoryTypeStack.addArrangedSubview(recipeCategory)
                

                return categoryTypeStack
            }()
            
            var difficultyStack:UIStackView = {
                let difficultyStack = UIStackView()
                difficultyStack.axis = .horizontal
                difficultyStack.alignment = .center
                difficultyStack.distribution = .fillProportionally
                
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
                
                return difficultyStack
            }()
            
            infoStack.addArrangedSubview(recipeName)
            infoStack.addArrangedSubview(categoryTypeStack)
            infoStack.addArrangedSubview(difficultyStack)
            
            recipeName.heightAnchor.constraint(equalToConstant: contentView.frame.height*0.3).isActive = true
            recipeName.widthAnchor.constraint(equalTo: infoStack.widthAnchor).isActive = true
            
            categoryTypeStack.heightAnchor.constraint(equalToConstant: contentView.frame.height*0.3).isActive = true
            categoryTypeStack.widthAnchor.constraint(equalTo: infoStack.widthAnchor).isActive = true
            
            difficultyStack.heightAnchor.constraint(equalToConstant: contentView.frame.height*0.3).isActive = true
            difficultyStack.widthAnchor.constraint(equalTo: infoStack.widthAnchor).isActive = true
            
            return infoStack
        }()
        
        outerView.addArrangedSubview(recipeImage)
        outerView.addArrangedSubview(infoStack)
        
        recipeImage.widthAnchor.constraint(equalToConstant: contentView.frame.width*0.5).isActive = true
        infoStack.widthAnchor.constraint(equalToConstant: contentView.frame.width*0.5).isActive = true
        infoStack.heightAnchor.constraint(equalTo: outerView.heightAnchor).isActive = true

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
        print(contentView.frame)
        outerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        outerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        outerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        outerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
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

