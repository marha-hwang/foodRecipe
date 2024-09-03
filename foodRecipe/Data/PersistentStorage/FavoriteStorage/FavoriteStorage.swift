//
//  FavoriteStorage.swift
//  foodRecipe
//
//  Created by haram on 7/1/24.
//

import Foundation

protocol FavoriteStorage{
    func fetchFavoriteRecipe(
        completion: @escaping (Result<[Recipe], Error>) -> Void
    )
    func saveFavoriteRecipe(
        recipe:Recipe,
        completion: @escaping (Result<Bool, Error>) -> Void
    )
    
    func removeFavoriteRecipe(
        recipe:Recipe,
        completion: @escaping (Result<Bool, Error>) -> Void
    )
}
