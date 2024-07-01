//
//  RecipeResponseStorage.swift
//  foodRecipe
//
//  Created by h2o on 2024/06/24.
//

import Foundation

protocol RecipeQueryStorage {
    func fetchRecentsQueries(
        maxCount: Int,
        completion: @escaping (Result<[RecipeQuery], Error>) -> Void
    )
    func saveRecentQuery(
        query: RecipeQuery,
        completion: @escaping (Result<RecipeQuery, Error>) -> Void
    )
    
    func removeRecentQuery(
        completion: @escaping (Result<Bool, Error>) -> Void
    )
}
