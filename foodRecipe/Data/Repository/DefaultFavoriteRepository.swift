//
//  DefaultFavoriteRepository.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

class DefaultFavoriteRepository:FavoriteRepository{
    
    private var favoriteStorage:FavoriteStorage
    
    init(favoriteStorage: FavoriteStorage) {
        self.favoriteStorage = favoriteStorage
    }
    
    func fetchFavoriteList(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        favoriteStorage.fetchFavoriteRecipe(seq:nil, completion: completion)
    }
    
    func fetchFavoriteBySeq(seq: String, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        favoriteStorage.fetchFavoriteRecipe(seq:seq, completion: completion)
    }
    
    func saveFavorite(recipe: Recipe, completion: @escaping (Result<Bool, Error>) -> Void) {
        favoriteStorage.saveFavoriteRecipe(recipe: recipe, completion: completion)
    }
    
    func removeFavorite(seq:String, completion: @escaping (Result<Bool, Error>) -> Void) {
        favoriteStorage.removeFavoriteRecipe(seq: seq, completion: completion)
    }
    
}
