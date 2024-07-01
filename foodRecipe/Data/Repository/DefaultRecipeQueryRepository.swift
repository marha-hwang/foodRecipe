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
    
    func fetchRecentsQueries(maxCount: Int, completion: @escaping (Result<[RecipeQuery], Error>) -> Void) {
        recipeQueryStorage.fetchRecentsQueries(maxCount: maxCount, completion: completion)
    }
    
    func saveRecentQuery(query: RecipeQuery, completion: @escaping (Result<RecipeQuery, Error>) -> Void) {
        recipeQueryStorage.saveRecentQuery(query: query, completion: completion)
    }
    
    func removeRecentQuery(completion: @escaping (Result<Bool, Error>) -> Void) {
        recipeQueryStorage.removeRecentQuery(completion: completion)
    }
    
    
}
