//
//  FavoriteStorage.swift
//  foodRecipe
//
//  Created by haram on 7/1/24.
//

import Foundation

protocol FavoriteStorage{
    func fetchFavoriteRecipe(
        completion: @escaping (Result<[RecipeFavorite], Error>) -> Void
    )
    func saveFavoriteRecipe(
        favorite:RecipeFavorite,
        completion: @escaping (Result<Bool, Error>) -> Void
    )
    
    func removeFavoriteRecipe(
        favorite:RecipeFavorite,
        completion: @escaping (Result<Bool, Error>) -> Void
    )
}
