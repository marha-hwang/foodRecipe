//
//  Recipe.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

struct Recipe:Codable{
    let ingredients:[String]
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
    let manual1:String
    let manual1_img:String
    let manual2:String
    let manual2_img:String
    let manual3:String
    let manual3_img:String
    let manual4:String
    let manual4_img:String
    let manual5:String
    let manual5_img:String
    let manual6:String
    let manual6_img:String
    let manual7:String
    let manual7_img:String
    let manual8:String
    let manual8_img:String
    let manual9:String
    let manual9_img:String
    let manual10:String
    let manual10_img:String
    let manual11:String
    let manual11_img:String
    let manual12:String
    let manual12_img:String
    let manual13:String
    let manual13_img:String
    let manual14:String
    let manual14_img:String
    let manual15:String
    let manual15_img:String
    let manual16:String
    let manual16_img:String
    let manual17:String
    let manual17_img:String
    let manual18:String
    let manual18_img:String
    let manual19:String
    let manual19_img:String
    let manual20:String
    let manual20_img:String
}

struct RecipePage{
    let perPage:Int
    let total_count: Int
    let recpies: [Recipe]
}

