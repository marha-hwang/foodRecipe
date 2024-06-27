//
//  RecipeQuery.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

struct RecipeQuery:Encodable{
    let recipe_name:String?
    let recipe_ingredient:String?
    let recipe_type:String?
}
