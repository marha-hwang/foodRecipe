//
//  FavoriteRecipeListViewModel.swift
//  foodRecipe
//
//  Created by h2o on 2024/09/06.
//

import Foundation

struct FavoriteRecipeListViewModelActions{
    let showRecipeDetail:(Recipe)->Void
}

protocol FavoriteRecipeListViewModelInput{
    func viewDidLoad()
    func viewWillAppear()
    func didTouchRecipe(index:Int)
}

protocol FavoriteRecipeListViewModelOutput{
    var title:String {get}
    var recipeItems:Observable<[Recipe]> {get}
}

typealias FavoriteRecipeListViewModel = FavoriteRecipeListViewModelInput&FavoriteRecipeListViewModelOutput

final class DefaultFavoriteRecipeListViewModel:FavoriteRecipeListViewModel{    
    
    private let favoriteRepository:FavoriteRepository
    private let actions:FavoriteRecipeListViewModelActions
    
    //MARK: OUTPUT
    var title: String = "즐겨찾기 레시피"
    var recipeItems: Observable<[Recipe]> = Observable([])
    
    init(favoriteRepository:FavoriteRepository, actions:FavoriteRecipeListViewModelActions){
        self.favoriteRepository = favoriteRepository
        self.actions = actions
    }
    
    private func fetchRecipe(){
        favoriteRepository.fetchFavoriteList{ [weak self] result in
            switch result{
            case .success(let result):
                self?.recipeItems.value = result
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

//MARK: INPUT
extension DefaultFavoriteRecipeListViewModel{
    func viewDidLoad() {
        fetchRecipe()
    }
    
    func viewWillAppear() {
        fetchRecipe()
    }
    
    func didTouchRecipe(index: Int) {
        actions.showRecipeDetail(recipeItems.value[index])
    }

}

