//
//  DefaultSearchQueryRepository.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

class DefaultRecipeQueryRepository:RecipeQueriesRepository{
    
    private var recipeQueryStorage:RecipeQueryStorage
    
    init(recipeQueryStorage: RecipeQueryStorage) {
        self.recipeQueryStorage = recipeQueryStorage
    }
    
    func fetchRecentsQueries(maxCount: Int, completion: @escaping (Result<[RecipeQueryHistory], Error>) -> Void) {
        recipeQueryStorage.fetchRecentsQueries(maxCount: maxCount, completion: completion)
    }
    
    func saveRecentQuery(query: RecipeQueryHistory, completion: @escaping (Result<RecipeQueryHistory, Error>) -> Void) {
        recipeQueryStorage.saveRecentQuery(query: query, completion: completion)
    }
    
    func removeRecentQuery(queryId:String?, completion: @escaping (Result<Bool, Error>) -> Void) {
        recipeQueryStorage.removeRecentQuery(queryId:queryId, completion: completion)
    }
    
    
}
