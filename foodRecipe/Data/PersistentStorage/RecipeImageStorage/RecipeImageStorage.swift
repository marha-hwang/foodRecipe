//
//  RecipeImageStorage.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/30.
//

import Foundation

protocol RecipeImageStorage {
    func fetchRecipeImage(
        imagePath: String,
        completion: @escaping (Result<Data?, Error>) -> Void
    )
    
    func saveRecipeImage(
        imagePath: String,
        imageData: Data,
        completion: @escaping (Result<Data, Error>) -> Void
    )
}
