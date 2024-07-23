//
//  RecipeMainItemCell.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/23.
//

import Foundation
import UIKit

class RecipeMainItemCell:UICollectionViewCell{
    static let identifier = "RecipeMainItemCell"
    
    lazy var outerView:UIStackView = {
        let outerView = UIStackView()
        outerView.axis = .vertical
        outerView.alignment = .center
        outerView.distribution = .fillProportionally
        
        outerView.translatesAutoresizingMaskIntoConstraints = false
        outerView.backgroundColor = .yellow
        
        return outerView
    }()
    
    lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    lazy var recipeName:UITextView = {
        let recipeName = UITextView()
        recipeName.translatesAutoresizingMaskIntoConstraints = false
        recipeName.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)

        recipeName.textAlignment = .center
        
        
        return recipeName
    }()
    
    lazy var infoStack:UIStackView = {
        let infoStack = UIStackView()
        infoStack.axis = .horizontal
        infoStack.alignment = .center
        infoStack.distribution = .fillProportionally
        
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        infoStack.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
        
        return infoStack
    }()
    
    lazy var recipeType:UITextView = {
        let recipeType = UITextView()
        recipeType.translatesAutoresizingMaskIntoConstraints = false
        recipeType.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
        
        return recipeType
    }()
    
    lazy var recipeCategory:UITextView = {
        let recipeCategory = UITextView()
        recipeCategory.translatesAutoresizingMaskIntoConstraints = false
        recipeCategory.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
 
        return recipeCategory
    }()
    
    lazy var difficultyStack:UIStackView = {
        let difficultyStack = UIStackView()
        difficultyStack.axis = .horizontal
        difficultyStack.alignment = .center
        difficultyStack.distribution = .fillProportionally
        
        recipeCategory.translatesAutoresizingMaskIntoConstraints = false
        recipeCategory.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
        
        return difficultyStack
    }()
    
    lazy var difficultyLabel:UITextView = {
        let difficultyLabel = UITextView()
        difficultyLabel.translatesAutoresizingMaskIntoConstraints = false
        difficultyLabel.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
        difficultyLabel.text = "조리 난이도"
        difficultyLabel.sizeToFit()
        
        return difficultyLabel
    }()
    
    lazy var difficultyStar:UIStackView = {
        let difficultyStar = UIStackView()
        difficultyStar.translatesAutoresizingMaskIntoConstraints = false
        difficultyStar.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
        
        return difficultyStar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        addLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bind(image:UIImage, recipeName:String, recipeCategory:String, recipeType:String, difficultyStar:Int){
        imageView.image = image
        self.recipeName.text = recipeName
        self.recipeCategory.text = recipeCategory
        self.recipeType.text = recipeType
    }
    
    private func addViews(){
        contentView.addSubview(outerView)
        
        outerView.addArrangedSubview(imageView)
        outerView.addArrangedSubview(recipeName)
        outerView.addArrangedSubview(infoStack)
        outerView.addArrangedSubview(difficultyStack)
        
        infoStack.addArrangedSubview(recipeType)
        infoStack.addArrangedSubview(recipeCategory)
        
        difficultyStack.addArrangedSubview(difficultyLabel)
        difficultyStack.addArrangedSubview(difficultyStar)
    }
    
    private func addLayout(){
        outerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        outerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        outerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        outerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        
        ///outerView는 크기가 정해지지 않았는데 contentView는 이미 정해져 있는 이유는? collectionView를 생성할 때 셀의 크기를 미리 선언하고 생성해서임
        //print(outerView.frame) 
        //print(contentView.frame)
        
        imageView.heightAnchor.constraint(equalToConstant: contentView.frame.height*0.5).isActive = true
        
        recipeName.heightAnchor.constraint(equalToConstant: contentView.frame.height*0.2).isActive = true
        recipeName.widthAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
        
        infoStack.heightAnchor.constraint(equalToConstant: contentView.frame.height*0.1).isActive = true
        infoStack.widthAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
        
        difficultyStack.heightAnchor.constraint(equalToConstant: contentView.frame.height*0.2).isActive = true
        difficultyStack.widthAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
        
        recipeCategory.widthAnchor.constraint(equalToConstant: contentView.frame.width*0.5).isActive = true
        recipeCategory.heightAnchor.constraint(equalToConstant: contentView.frame.height*0.1).isActive = true
        
        recipeType.widthAnchor.constraint(equalToConstant: contentView.frame.width*0.5).isActive = true
        recipeType.heightAnchor.constraint(equalToConstant: contentView.frame.height*0.1).isActive = true
        
        difficultyLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width*0.5).isActive = true
        difficultyLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height*0.2).isActive = true
        
        difficultyStar.widthAnchor.constraint(equalToConstant: contentView.frame.width*0.5).isActive = true
        difficultyStar.heightAnchor.constraint(equalToConstant: contentView.frame.height*0.2).isActive = true
        
    }
}

