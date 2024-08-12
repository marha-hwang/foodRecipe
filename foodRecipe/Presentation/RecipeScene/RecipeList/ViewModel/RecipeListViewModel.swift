//
//  RecipeListByKeywordViewModel.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/22.
//

import Foundation

struct RecipeListViewModelActions{
    let showRecipeDetail:(Recipe)->Void
    let showRecipeQuriesList:()->Void
}

protocol RecipeListViewModelInput{
    func viewDidLoad()
    func didTouchSearchButton()
    func didTouchCategory(category:String)
    func didTouchRecipe(index:Int)
}

protocol RecipeListViewModelOutput{
    var recipeItems:Observable<[Recipe]> {get}
    var title:String {get}
    var categoryItems:[String] {get}
    
}

typealias RecipeListViewModel = RecipeListViewModelInput&RecipeListViewModelOutput

final class DefaultRecipeListViewModel:RecipeListViewModel{
    
    private let searchRecipeUseCase:SearchRecipeUseCase
    private let actions:RecipeListViewModelActions?
    
    
    var recipeItems: Observable<[Recipe]> = Observable([])
    var title: String = ""
    var categoryItems: [String] = []
    
    init(searchRecipeUseCase: SearchRecipeUseCase,
         actions:RecipeListViewModelActions
    ) {
        self.searchRecipeUseCase = searchRecipeUseCase
        self.actions = actions
    }
    
}

extension DefaultRecipeListViewModel{
    func viewDidLoad() {
        
    }
    
    func didTouchRecipe(index: Int) {
        
    }
    
    func didTouchSearchButton() {
        
    }
    
    func didTouchCategory(category: String) {
        
    }
}
