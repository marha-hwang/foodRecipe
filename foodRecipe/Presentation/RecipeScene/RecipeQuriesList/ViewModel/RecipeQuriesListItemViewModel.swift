//
//  RecipeQuriesListItemViewModel.swift
//  foodRecipe
//
//  Created by h2o on 2024/08/07.
//

import Foundation

struct RecipeQuriesListItemViewModel{
    let keyword:String
    let reg_date:String
    
    init(recipeQuery:RecipeQueryHistory) {
        self.keyword = recipeQuery.recipe_name
        self.reg_date = dateFormat(date: recipeQuery.reg_date ?? Date())
        
        func dateFormat(date:Date)->String{
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yy.MM.dd"
            let dateStr = dateFormatter.string(from: Date())
            return dateStr
        }
    }
    
}
