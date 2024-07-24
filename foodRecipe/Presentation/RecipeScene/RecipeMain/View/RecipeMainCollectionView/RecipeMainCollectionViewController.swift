//
//  RecipeMainCollectionViewController.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/23.
//

import Foundation
import UIKit

class RecipeMainCollectionViewController:UICollectionViewController{
    
    init(collectionViewLayout layout: UICollectionViewFlowLayout) {
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 300)
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .orange
        collectionView.register(RecipeMainItemCell.self, forCellWithReuseIdentifier: RecipeMainItemCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

    }
    
    override func didMove(toParent parent: UIViewController?) {  
        print("didMove")
    }
}

extension RecipeMainCollectionViewController{    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeMainItemCell.identifier, for: indexPath) as! RecipeMainItemCell
        
        cell.bind(image: UIImage(named: "logo") ?? UIImage(), recipeName: "햄버거", recipeCategory: "양식", recipeType: "구이", difficultyStar: 3)
        return cell
    }
}
