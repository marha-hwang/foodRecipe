//
//  APIEndpoints.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

struct APIEndpoints{
    static func getRecipe(with:RecipeRequestDTO) -> URLRequest{
        let startIdx = (with.page-1)*with.perCount + 1
        var baseurl = "\(AppConfiguration().apiBaseURL)\(AppConfiguration().apiKey)/COOKRCP01/json/\(startIdx)/\(startIdx+with.perCount-1)"
        
        if let recipeName = with.query.recipe_name{
            baseurl = "\(baseurl)/RCP_NM=\(recipeName)"
        }
        
        if let recipeType = with.query.recipe_type{
            baseurl = "\(baseurl)&RCP_PAT2=\(recipeType)"
        }
        
        if let recipeIngredient = with.query.recipe_ingredient{
            baseurl = "\(baseurl)&RCP_PARTS_DTLS=\(recipeIngredient)"
        }
        
        
        let url = URL(string: baseurl)
        
        print(url)
        return URLRequest(url: url!)
    }
}
