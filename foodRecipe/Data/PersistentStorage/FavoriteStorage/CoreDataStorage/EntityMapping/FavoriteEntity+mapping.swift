//
//  Favorite+mapping.swift
//  foodRecipe
//
//  Created by haram on 7/1/24.
//

import Foundation
import CoreData

extension RecipeFavoriteEntity {
    convenience init(recipe:Recipe, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        recipe_seq = recipe_seq
        recipe_data = try? JSONEncoder().encode(recipe)

    }
}

extension RecipeFavoriteEntity {
    func toDomain() -> Recipe {
        
        let recipe = try! JSONDecoder().decode(Recipe.self, from: recipe_data!)
        
        return recipe
    }
}
