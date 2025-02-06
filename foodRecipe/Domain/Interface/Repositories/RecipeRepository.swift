//
//  RecipeRepository.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

protocol RecipeRepository {
    func fetchRecipesList(
        query: RecipeQuery,
        page: Int
    ) async throws -> RecipePage?
}
