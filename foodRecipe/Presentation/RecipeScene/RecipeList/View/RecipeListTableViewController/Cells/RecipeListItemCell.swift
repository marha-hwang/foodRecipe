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
        outerView.axis = .vertical
        outerView.alignment = .center
        outerView.distribution = .fillProportionally
        
        outerView.translatesAutoresizingMaskIntoConstraints = false
        
        lazy var infoStack:UIStackView = {
            let infoStack = UIStackView()
            infoStack.axis = .horizontal
            infoStack.alignment = .center
            infoStack.distribution = .fillProportionally
            
            infoStack.translatesAutoresizingMaskIntoConstraints = false
            infoStack.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
            
            infoStack.addArrangedSubview(recipeType)
            infoStack.addArrangedSubview(recipeCategory)
            
            recipeCategory.widthAnchor.constraint(equalToConstant: contentView.frame.width*0.5).isActive = true
            recipeCategory.heightAnchor.constraint(equalToConstant: contentView.frame.height*0.1).isActive = true
            
            recipeType.widthAnchor.constraint(equalToConstant: contentView.frame.width*0.5).isActive = true
            recipeType.heightAnchor.constraint(equalToConstant: contentView.frame.height*0.1).isActive = true
            
            return infoStack
        }()
        
        lazy var difficultyStack:UIStackView = {
            let difficultyStack = UIStackView()
            difficultyStack.axis = .horizontal
            difficultyStack.alignment = .center
            difficultyStack.distribution = .fillProportionally
            
            recipeCategory.translatesAutoresizingMaskIntoConstraints = false
            
            lazy var difficultyLabel:UITextView = {
                let difficultyLabel = UITextView()
                difficultyLabel.translatesAutoresizingMaskIntoConstraints = false
                difficultyLabel.text = "조리 난이도"
                difficultyLabel.sizeToFit()
                
                return difficultyLabel
            }()
            
            difficultyStack.addArrangedSubview(difficultyLabel)
            difficultyStack.addArrangedSubview(difficultyStar)
            
            difficultyLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width*0.5).isActive = true
            difficultyLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height*0.2).isActive = true
            
            difficultyStar.widthAnchor.constraint(equalToConstant: contentView.frame.width*0.5).isActive = true
            difficultyStar.heightAnchor.constraint(equalToConstant: contentView.frame.height*0.2).isActive = true
            
            return difficultyStack
        }()
        
        outerView.addArrangedSubview(recipeImage)
        outerView.addArrangedSubview(recipeName)
        outerView.addArrangedSubview(infoStack)
        outerView.addArrangedSubview(difficultyStack)
        
        recipeImage.heightAnchor.constraint(equalToConstant: contentView.frame.height*0.7).isActive = true
        
        recipeName.heightAnchor.constraint(equalToConstant: contentView.frame.height*0.1).isActive = true
        recipeName.widthAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
        
        infoStack.heightAnchor.constraint(equalToConstant: contentView.frame.height*0.1).isActive = true
        infoStack.widthAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
        
        difficultyStack.heightAnchor.constraint(equalToConstant: contentView.frame.height*0.1).isActive = true
        difficultyStack.widthAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
        
        return outerView
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        addLayout()
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
    
    private func addViews(){
        contentView.addSubview(outerView)
    }
    
    private func addLayout(){
        outerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        outerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        outerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        outerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        
        ///outerView는 크기가 정해지지 않았는데 contentView는 이미 정해져 있는 이유는? collectionView를 생성할 때 셀의 크기를 미리 선언하고 생성해서임
        //print(outerView.frame)
        //print(contentView.frame)
    }
}

