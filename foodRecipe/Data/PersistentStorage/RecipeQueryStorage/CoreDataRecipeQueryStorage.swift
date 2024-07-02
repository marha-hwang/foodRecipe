//
//  CoreDataResponseStorage.swift
//  foodRecipe
//
//  Created by h2o on 2024/06/24.
//

import Foundation

class CoreDataRecipeQueryStorage:RecipeQueryStorage{
    
    private let coreDataStorage: CoreDataStorage
    
    init(coreDataStorage: CoreDataStorage) {
        self.coreDataStorage = coreDataStorage
    }
    
    func fetchRecentsQueries(maxCount: Int, completion: @escaping (Result<[RecipeQuery], Error>) -> Void) {
        RecipeQueryE
    }
    
    func saveRecentQuery(query: RecipeQuery, completion: @escaping (Result<RecipeQuery, Error>) -> Void) {
        <#code#>
    }
    
    func removeRecentQuery(completion: @escaping (Result<Bool, Error>) -> Void) {
        <#code#>
    }
    
    
}
