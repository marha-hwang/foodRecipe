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
    
    func fetchFavoriteList(completion: @escaping (Result<[RecipeFavorite], Error>) -> Void) {
        favoriteStorage.fetchFavoriteRecipe(completion: completion)
    }
    
    func saveFavorite(favorite: RecipeFavorite, completion: @escaping (Result<Bool, Error>) -> Void) {
        favoriteStorage.saveFavoriteRecipe(favorite: favorite, completion: completion)
    }
    
    func removeFavorite(favorite: RecipeFavorite, completion: @escaping (Result<Bool, Error>) -> Void) {
        favoriteStorage.removeFavoriteRecipe(favorite: favorite, completion: completion)
    }
    
    
}
