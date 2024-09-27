//
//  Recipe.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

struct ManualItem:Codable{
    let imageUrl:String
    let description:String
}

struct Recipe:Codable{
    let ingredients:String
    let main_image:String
    let cookWay:String
    let recipe_type:String
    let recipe_tip:String
    let hash_tag:String
    let info_wgt:String
    let info_na:String
    let info_pro:String
    let info_fat:String
    let info_cal:String
    let info_eng:String
    let recipe_seq:String
    let recipe_name:String
    let manual:[ManualItem] 
}

struct RecipePage{
    let perPage:Int
    let total_count: Int
    let recpies: [Recipe]
}

