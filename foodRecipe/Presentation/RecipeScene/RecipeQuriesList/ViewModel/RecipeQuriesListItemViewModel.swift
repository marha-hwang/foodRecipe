//
//  RecipeQuriesListItemViewModel.swift
//  foodRecipe
//
//  Created by h2o on 2024/08/07.
//

import Foundation

//셀을 모듈화시키기 위해 셀의 이벤트는 해당 셀 내부에서 처리하기 위해 구현함
struct RecipeQuriesListItemViewModelActions{
    let didDeleteQuery:(String)->Void
}

struct RecipeQuriesListItemViewModel{
    let actions:RecipeQuriesListItemViewModelActions?
    let queryId:String
    let keyword:String
    let reg_date:String
    
    init(recipeQuery:RecipeQueryHistory, actions:RecipeQuriesListItemViewModelActions) {
        
        self.actions = actions
        self.queryId = recipeQuery.query_id
        self.keyword = recipeQuery.recipe_name
        self.reg_date = dateFormat(date: recipeQuery.reg_date ?? Date())
        
        func dateFormat(date:Date)->String{
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yy.MM.dd"
            let dateStr = dateFormatter.string(from: Date())
            return dateStr
        }
    }
    
    func deleteItem(){
        actions?.didDeleteQuery(queryId)
    }
    
}
