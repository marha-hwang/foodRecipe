//
//  RemoveRecentRecipeQuriesUseCase.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

protocol RemoveRecentRecipeQuriesUseCase{
    func excute(
        queryId:String?,
        completion: @escaping (Result<Bool, Error>) -> Void
    )
}

class DefaultRemoveRecentRecipeQuriesUseCase:RemoveRecentRecipeQuriesUseCase{
    
    private let recipeQueriesRepository:RecipeQueriesRepository
    
    init(recipeQueriesRepository: RecipeQueriesRepository) {
        self.recipeQueriesRepository = recipeQueriesRepository
    }
    
    func excute(queryId:String?,completion: @escaping (Result<Bool, Error>) -> Void) {
        recipeQueriesRepository.removeRecentQuery(queryId:queryId, completion: completion)
    }
    
}
