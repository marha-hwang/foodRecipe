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
        completion: @escaping (Result<[RecipeQueryHistory], Error>) -> Void
    )
    func saveRecentQuery(
        query: RecipeQueryHistory,
        completion: @escaping (Result<RecipeQueryHistory, Error>) -> Void
    )
    
    func removeRecentQuery(
        queryId:String?,
        completion: @escaping (Result<Bool, Error>) -> Void
    )
}
