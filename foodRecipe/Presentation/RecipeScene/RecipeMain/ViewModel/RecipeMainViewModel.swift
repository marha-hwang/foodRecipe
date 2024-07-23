//
//  RecipeMainViewModel.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/22.
//

import Foundation

struct RecipeMainViewModelActions{
    let showRecipeQuriesList:()->Void
    let showRecipeListByKeyword:(String)->Void
    let showRecipeListByCategory:(String)->Void
    let showRecipeDetail:(Recipe)->Void
}

protocol RecipeMainViewModelInput{
    func showRecipeQuriesList()
    func showRecipeListByKeyword(keyword:String)
    func showRecipeListByCategory(category:String)
    func showRecipeDetail(recipe:Recipe)
    func openCategory()
    func closeCategory()
}

protocol RecipeMainViewModelOutput{
    var searchbarPlaceholder:String {get}
    var categoryItems:[FolderViewItem] {get}
    var weatherRecommandTitle:Observable<String> {get}
    var weatherRecommandItems:Observable<[Recipe]> {get}
    var timeRecommandTitle:String {get}
    var timeRecommandItems:Observable<[Recipe]> {get}
}

typealias RecipeMainViewModel = RecipeMainViewModelInput&RecipeMainViewModelOutput

final class DefaultRecipeMainViewModel:RecipeMainViewModel{
    
    private let searchRecipeUsecase:SearchRecipeUseCase
    private let actions:RecipeMainViewModelActions?
    
    // MARK: OUTPUT
    var searchbarPlaceholder: String = ""
    var categoryItems: [FolderViewItem] = []
    var weatherRecommandTitle: Observable<String> = Observable("")
    var weatherRecommandItems: Observable<[Recipe]> = Observable([])
    var timeRecommandTitle: String = ""
    var timeRecommandItems: Observable<[Recipe]> = Observable([])
    
    init(searchRecipeUsecase: SearchRecipeUseCase, actions: RecipeMainViewModelActions?) {
        self.searchRecipeUsecase = searchRecipeUsecase
        self.actions = actions
    }
    
}


//MARK: INPUT
extension DefaultRecipeMainViewModel{
    func showRecipeQuriesList() {
        
    }
    
    func showRecipeListByKeyword(keyword: String) {
    
    }
    
    func showRecipeListByCategory(category: String) {
        
    }
    
    func showRecipeDetail(recipe: Recipe) {
        
    }
    
    func openCategory() {
        
    }
    
    func closeCategory() {
        
    }
}
