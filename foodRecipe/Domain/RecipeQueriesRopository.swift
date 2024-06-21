//
//  SearchQueryRopository.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

protocol RecipeQueriesRepository {
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
