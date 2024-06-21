//
//  RecipeRepository.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

protocol RecipeRepository {
    @discardableResult
    func fetchRecipesList(
        query: RecipeQuery,
        page: Int,
        cached: @escaping (RecipePage) -> Void,
        completion: @escaping (Result<RecipePage, Error>) -> Void
    ) -> Cancellable?
}
