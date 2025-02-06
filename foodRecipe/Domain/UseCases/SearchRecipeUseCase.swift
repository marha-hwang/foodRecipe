//
//  SearchRecipeUseCase.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

//Cancellable : 네트워크 작업에서 중간에 작업을 취소하기 위해 사용하는 프로토콜이다.
protocol SearchRecipeUseCase {
    func execute(
        requestValue: SearchRecipeUseCaseRequestValue
    ) async throws-> RecipePage?
}

final class DefaultSearchRecipeUseCase: SearchRecipeUseCase {

    private let recipeRepository: RecipeRepository
    private let recipeQueryQueriesRepository: RecipeQueriesRepository

    init(
        recipeRepository: RecipeRepository,
        recipeQueryQueriesRepository: RecipeQueriesRepository
    ) {

        self.recipeRepository = recipeRepository
        self.recipeQueryQueriesRepository = recipeQueryQueriesRepository
    }

    func execute(
        requestValue: SearchRecipeUseCaseRequestValue
    ) async throws -> RecipePage? {

        //검색한 내용을 저장하기 위한 코드
        if requestValue.isSave{
            
            let str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let size = 5
            let iv = str.createRandomStr(length: size)
            
            let queryHistory = RecipeQueryHistory(query_id: iv, recipe_name: requestValue.query.recipe_name ?? "", reg_date: Date())
            
            self.recipeQueryQueriesRepository.saveRecentQuery(query: queryHistory) { _ in }
        }
        
        let result = try? await recipeRepository.fetchRecipesList(query: requestValue.query, page: requestValue.page)

        return result
    }
}

struct SearchRecipeUseCaseRequestValue {
    let query: RecipeQuery
    let page: Int
    let isSave: Bool
}
