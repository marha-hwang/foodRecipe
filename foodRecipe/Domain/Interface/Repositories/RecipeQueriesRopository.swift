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
