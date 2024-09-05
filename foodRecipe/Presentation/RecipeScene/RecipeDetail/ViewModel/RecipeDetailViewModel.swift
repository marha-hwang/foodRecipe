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
    
    private let checkFavoriteUesCase:CheckFavoriteUseCase
    private let changeFavoriteStatusUseCase:ChangeFavoriteStatusUseCase
    
    //MARK: OUTPUT
    var favoriteStatus: Observable<Bool> = Observable(false)
    var recipe: Recipe
    
    init(checkFavoriteUesCase: CheckFavoriteUseCase, changeFavoriteStatusUseCase:ChangeFavoriteStatusUseCase, recipe: Recipe) {
        self.checkFavoriteUesCase = checkFavoriteUesCase
        self.changeFavoriteStatusUseCase = changeFavoriteStatusUseCase
        self.recipe = recipe
    }
    
    //MARK: PRIVATE
    private func getFavoriteStatus(){
        checkFavoriteUesCase.excute(seq: recipe.recipe_seq){ [weak self] result in
            switch result{
            case .success(let result):
                self?.favoriteStatus.value = result
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updateFavoriteStatus(){
        changeFavoriteStatusUseCase.excute(recipe: recipe){ [weak self] result in
            switch result{
            case .success(let result):
                self?.favoriteStatus.value = result
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

//MARK: INPUT
extension DefaultRecipeDetailViewModel{
    func viewDidLoad() {
        getFavoriteStatus()
    }
    
    func didTouchFavorite() {
        updateFavoriteStatus()
    }
}
