//
//  RecipeDetailViewModel.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

protocol RecipeDetailViewModelInput{
    func viewDidLoad()
    func didTouchFavorite()
}

protocol RecipeDetailViewModelOutput{
    var favoriteStatus:Observable<Bool> {get}
    var recipe:Recipe {get}
}

typealias RecipeDetailViewModel = RecipeDetailViewModelInput&RecipeDetailViewModelOutput

final class DefaultRecipeDetailViewModel:RecipeDetailViewModel{
    
    private let addFavoriteUesCase:AddFavoriteUseCase
    
    //MARK: OUTPUT
    var favoriteStatus: Observable<Bool> = Observable(false)
    var recipe: Recipe
    
    init(addFavoriteUesCase: AddFavoriteUseCase, recipe: Recipe) {
        self.addFavoriteUesCase = addFavoriteUesCase
        self.recipe = recipe
    }
    
}

//MARK: INPUT
extension DefaultRecipeDetailViewModel{
    func viewDidLoad() {
        
    }
    
    func didTouchFavorite() {
        
    }
}
