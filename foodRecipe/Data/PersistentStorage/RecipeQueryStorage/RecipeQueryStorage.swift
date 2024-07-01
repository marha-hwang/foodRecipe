//
//  RecipeResponseStorage.swift
//  foodRecipe
//
//  Created by h2o on 2024/06/24.
//

import Foundation

protocol RecipeResponseStorage {
    func getResponse(
        for request: RecipeRequestDTO,
        completion: @escaping (Result<RecipeRequestDTO?, Error>) -> Void
    )
    func save(response: RecipeRequestDTO, for requestDto: RecipeRequestDTO)
}
