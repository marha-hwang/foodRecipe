//
//  RecipeRequestDTO+Mapping.swift
//  foodRecipe
//
//  Created by h2o on 2024/06/24.
//

import Foundation

struct RecipeRequestDTO:Encodable{
    let query:RecipeQuery
    let page:Int
    let perCount:Int
}
