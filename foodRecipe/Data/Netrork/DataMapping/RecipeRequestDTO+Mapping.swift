//
//  RecipeRequestDTO+Mapping.swift
//  foodRecipe
//
//  Created by h2o on 2024/06/24.
//

import Foundation

struct RecipeRequestDTO:Encodable{
    let recipe_name:String
    let recipe_ingredient:String
    let recipe_type:String
    let page:Int
}
