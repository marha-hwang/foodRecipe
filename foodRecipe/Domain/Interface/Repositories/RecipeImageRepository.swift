//
//  RecipeImageRepository.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

protocol RecipeImageRepository{
    func fetchImage(
        with imagePath: String,
        completion: @escaping (Result<Data, Error>) -> Void
    )
}


