//
//  RecipeMainItemCell.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/23.
//

import Foundation
import UIKit

class RecipeMainItemCell:UICollectionViewCell{
    static let reuseIdentifier = String(describing: RecipeMainItemCell.self)
    private var viewModel: RecipeMainItemViewModel!
    private var recipeImageRepository: RecipeImageRepository?
    
    lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        
        imageView.snp.makeConstraints{ make in
            make.height.equalTo(260.adjustH)
        }
        
        return imageView
    }()
    
    lazy var recipeName:UILabel = {
        let recipeName = UILabel()
        recipeName.textAlignment = .left
        recipeName.font = UIFont.systemFont(ofSize: 14)
        recipeName.sizeToFit()
        
        return recipeName
    }()
    
    lazy var recipeType:UILabel = {
        let recipeType = UILabel()
        recipeType.textAlignment = .center
        recipeType.font = UIFont.systemFont(ofSize: 12)
        recipeType.sizeToFit()
        
        return recipeType
    }()
    
    lazy var recipeCategory:UILabel = {
        let recipeCategory = UILabel()
        recipeCategory.textAlignment = .center
        recipeCategory.font = UIFont.systemFont(ofSize: 12)
        recipeCategory.sizeToFit()
        
        return recipeCategory
    }()
    
    lazy var difficulty:UILabel = {
        let difficulty = UILabel()
        difficulty.textAlignment = .center
        difficulty.font = UIFont.systemFont(ofSize: 12)
        difficulty.sizeToFit()
        
        return difficulty
    }()
    
    private lazy var outerView:UIStackView = {
        let outerView = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .leading)
        outerView.addArrangedSubview(imageView)
        outerView.addArrangedSubview(recipeName)

        
        lazy var infoStack:UIStackView = {
            let infoStack = UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .leading)

            let difficultyStack:UIStackView = {
                let difficultyStack = UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .top)
                
                difficultyStack.snp.makeConstraints{ make in
                    make.height.equalTo(30)
                }
                
                let difficultyImage:UIImageView = {
                    let difficultyImage = UIImageView()
                    difficultyImage.contentMode = .scaleToFill
                    difficultyImage.image = UIImage(systemName: "star.fill")
                    difficultyImage.tintColor = .black
                    return difficultyImage
                }()
                
                difficultyStack.addArrangedSubview(difficultyImage)
                difficultyStack.addArrangedSubview(difficulty)
                

                return difficultyStack
            }() 
            
            infoStack.addArrangedSubview(difficultyStack)
            infoStack.addArrangedSubview(recipeType)
            infoStack.addArrangedSubview(recipeCategory)
            
            return infoStack
        }()
        
        outerView.addArrangedSubview(infoStack)
        
        return outerView
    }()
    
    public func fill(viewModel:RecipeMainItemViewModel, recipeImageRepository:RecipeImageRepository?){
        self.viewModel = viewModel
        self.recipeImageRepository = recipeImageRepository
        
        //네크워로로 이미지를 불러와서 이미지를 채워넣어야 함
        updateImage()
        
        self.recipeName.text = viewModel.recipeName
        self.difficulty.text = String(viewModel.difficulty) + " / "
        self.recipeType.text = viewModel.recipeType + " / "
        self.recipeCategory.text = viewModel.recipeCategory
    }
    
    private func updateImage(){
        
        imageView.image = nil
        
        let _ = recipeImageRepository?.fetchImage(with: viewModel.imagePath){ [weak self] result in
            
            switch result{
            case .success(let data):
                DispatchQueue.main.async{
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(outerView)
        outerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        outerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        outerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        outerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

