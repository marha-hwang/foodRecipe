//
//  Favorite+mapping.swift
//  foodRecipe
//
//  Created by haram on 7/1/24.
//

import Foundation
import CoreData

extension RecipeFavoriteEntity {
    convenience init(favorite: RecipeFavorite, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        recipe_id = favorite.recipe_id
        recipe_name = favorite.recipe_name
        recipe_type = favorite.recipe_type
        recipe_way = favorite.recipe_way
        img_url = favorite.img_url
    }
}

extension RecipeFavoriteEntity {
    func toDomain() -> RecipeFavorite {
        return .init(recipe_id: recipe_id ?? "",
                     recipe_name: recipe_name ?? "",
                     recipe_type: recipe_type ?? "",
                     recipe_way: recipe_way ?? "",
                     img_url: img_url ?? "")
    }
}
