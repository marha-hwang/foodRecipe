//
//  APIEndpoints.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

struct APIEndpoints{
    static func getRecipe(with:RecipeRequestDTO) -> URLRequest{
        let baseurl = "\(AppConfiguration().apiBaseURL)\(AppConfiguration().apiKey)/COOKRCP01/json/\(with.page)/\(with.perCount-1)"
        
        let startIdx = ((with.page-1) * 10)+1
        
        let url = URL(string: "\(baseurl)/startIdx=\(String(startIdx))&endIdx=\(String(startIdx+9))&RCP_NM=\(with.query.recipe_name ?? "")&RCP_PARTS_DTLS=\(with.query.recipe_ingredient ?? "")&RCP_PAT2=\(with.query.recipe_type ?? "")")
        
        return URLRequest(url: url!)
    }
}
