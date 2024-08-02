//
//  RecipeQuriesListViewModel.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

struct RecipeQuriesListViewModelActions{
    let showRecipeListByKeyword:(String)->Void
}

protocol RecipeQuriesListViewModelInput{
    
}

protocol RecipeQuriesListViewModelOutput{
    
}

typealias RecipeQuriesListViewModel = RecipeQuriesListViewModelInput&RecipeQuriesListViewModelOutput

//final class DefaultRecipeQuriesListViewModel:RecipeQuriesListViewModel{
//
//    private let fetchQuriesUseCase:FetchRecentRecipeQuriesUseCase
//    private let removeQuriesUseCase:RemoveRecentRecipeQuriesUseCase
//    
//}
