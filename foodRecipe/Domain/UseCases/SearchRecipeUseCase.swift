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
        requestValue: SearchRecipeUseCaseRequestValue,
        completion: @escaping (Result<RecipePage, Error>) -> Void
    ) -> Cancellable?
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
        requestValue: SearchRecipeUseCaseRequestValue,
        completion: @escaping (Result<RecipePage, Error>) -> Void
    ) -> Cancellable? {

        return recipeRepository.fetchRecipesList(
            query: requestValue.query,
            page: requestValue.page,
            completion: { result in

            if case .success = result {
                if requestValue.isSave{
                    self.recipeQueryQueriesRepository.saveRecentQuery(query: requestValue.query) { _ in }
                }
            }

            completion(result)
        })
    }
}

struct SearchRecipeUseCaseRequestValue {
    let query: RecipeQuery
    let page: Int
    let isSave: Bool
}
