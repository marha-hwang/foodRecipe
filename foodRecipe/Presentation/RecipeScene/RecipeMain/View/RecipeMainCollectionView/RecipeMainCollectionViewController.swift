//
//  RecipeMainCollectionViewController.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/23.
//

import Foundation
import UIKit

class RecipeMainCollectionViewController:UICollectionViewController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeMainItemCell.identifier, for: indexPath) as! RecipeMainItemCell
        
        cell.bind(image: UIImage(named: "logo") ?? UIImage(), recipeName: "햄버거", recipeCategory: "양식", recipeType: "구이", difficultyStar: 3)
        return cell
    }
}
