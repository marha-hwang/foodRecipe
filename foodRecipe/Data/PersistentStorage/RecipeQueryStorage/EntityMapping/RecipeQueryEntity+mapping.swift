//
//  RecipeQueryEntity+mapping.swift
//  foodRecipe
//
//  Created by haram on 7/1/24.
//

import Foundation
import CoreData

extension RecipeQueryEntity {
    convenience init(recipeQuery: RecipeQueryHistory, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        queryId = recipeQuery.query_id
        recipe_name = recipeQuery.recipe_name
        reg_date = recipeQuery.reg_date
    }
}

extension RecipeQueryEntity {
    func toDomain() -> RecipeQueryHistory {
        return .init(query_id: queryId ?? "default",
                     recipe_name: recipe_name ?? "default",
                     reg_date: reg_date)
    }
}
