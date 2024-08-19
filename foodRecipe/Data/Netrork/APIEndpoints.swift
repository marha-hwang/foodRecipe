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
        let baseurl = "\(AppConfiguration().apiBaseURL)\(AppConfiguration().apiKey)/COOKRCP01/json/\(startIdx)/\(startIdx+with.perCount-1)"
        
        let url = URL(string: "\(baseurl)/RCP_NM=\(with.query.recipe_name ?? " ")&RCP_PAT2=\(with.query.recipe_type ?? " ")&RCP_PARTS_DTLS=\(with.query.recipe_ingredient ?? " ")")
        
        print(url)
        return URLRequest(url: url!)
    }
}
