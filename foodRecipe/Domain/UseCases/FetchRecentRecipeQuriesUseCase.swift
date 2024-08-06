//
//  FetchRecentRecipeQuriesUseCase.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

protocol FetchRecentRecipeQuriesUseCase{
    func excute(
        maxCount:Int,
        completion: @escaping (Result<[RecipeQueryHistory], Error>) -> Void
    )
}

final class DefaultFetchRecentRecipeQueriesUseCase:FetchRecentRecipeQuriesUseCase{
    
    private let recipeQueriesRepository:RecipeQueriesRepository
    
    init(recipeQueriesRepository: RecipeQueriesRepository) {
        self.recipeQueriesRepository = recipeQueriesRepository
    }
    
    func excute(maxCount: Int, completion: @escaping (Result<[RecipeQueryHistory], Error>) -> Void) {
        recipeQueriesRepository.fetchRecentsQueries(maxCount: maxCount,
                                                    completion: completion
        )
    }
    
    
}
