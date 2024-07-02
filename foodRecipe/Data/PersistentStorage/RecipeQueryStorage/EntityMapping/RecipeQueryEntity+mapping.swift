//
//  RecipeQueryEntity+mapping.swift
//  foodRecipe
//
//  Created by haram on 7/1/24.
//

import Foundation
import CoreData

extension RecipeQueryEntity {
    convenience init(recipeQuery: RecipeQuery, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        recipe_name = recipeQuery.recipe_name
        recipe_type = recipeQuery.recipe_type
        recipe_ingredient = recipeQuery.recipe_ingredient
    }
}

extension RecipeQueryEntity {
    func toDomain() -> RecipeQuery {
        return .init(recipe_name: recipe_name,
                     recipe_ingredient: recipe_ingredient,
                     recipe_type: recipe_type)
    }
}
