//
//  RecipeListItemCell.swift
//  foodRecipe
//
//  Created by haram on 8/12/24.
//

import Foundation
import UIKit

class RecipeListItemCell:UITableViewCell{
    static let reuseIdentifier = String(describing: RecipeMainItemCell.self)
    private var viewModel: RecipeListItemViewModel!
    private var recipeImageRepository: RecipeImageRepository?
    
    lazy var recipeImage:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true        
        imageView.layer.cornerRadius = 10
        
        return imageView
    }()
    
    lazy var recipeName:UILabel = {
        let recipeName = UILabel()
        recipeName.textAlignment = .left
        recipeName.numberOfLines = 0
        recipeName.font = UIFont.systemFont(ofSize: 16)
        return recipeName
    }()
    
    lazy var recipeType:UILabel = {
        let recipeType = UILabel()
        recipeType.textAlignment = .center
        recipeType.font = UIFont.systemFont(ofSize: 14)
        
        return recipeType
    }()
    
    lazy var recipeCategory:UILabel = {
        let recipeCategory = UILabel()
        recipeCategory.textAlignment = .center
        recipeCategory.font = UIFont.systemFont(ofSize: 14)
 
        return recipeCategory
    }()
    
    lazy var difficulty:UILabel = {
        let recipeCategory = UILabel()
        recipeCategory.textAlignment = .center
        recipeCategory.font = UIFont.systemFont(ofSize: 14)
 
        return recipeCategory
    }()
    
    private lazy var outerView:UIStackView = {
        let outerView = UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .center)
        outerView.addArrangedSubview(recipeImage)
        recipeImage.widthAnchor.constraint(equalTo: outerView.widthAnchor, multiplier: 0.5).isActive = true
        
        lazy var infoStack:UIStackView = {
            let infoStack = UIStackView(axis: .vertical, distribution: .equalCentering, alignment: .leading)
            infoStack.spacing = 5
            
            var categoryTypeStack:UIStackView = {
                let categoryTypeStack = UIStackView(axis: .horizontal, distribution: .equalCentering, alignment: .center)
                
                categoryTypeStack.addArrangedSubview(recipeType)
                categoryTypeStack.addArrangedSubview(recipeCategory)

                return categoryTypeStack
            }()
            
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
            
            infoStack.addArrangedSubview(recipeName)
            infoStack.addArrangedSubview(categoryTypeStack)
            infoStack.addArrangedSubview(difficultyStack)
            
            return infoStack
        }()
        outerView.addArrangedSubview(infoStack)
        infoStack.widthAnchor.constraint(equalTo: outerView.widthAnchor, multiplier: 0.45).isActive = true

        
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
        self.recipeType.text = viewModel.recipeType + " / "
        self.recipeCategory.text = viewModel.recipeCategory
        self.difficulty.text = String(viewModel.difficulty)
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

