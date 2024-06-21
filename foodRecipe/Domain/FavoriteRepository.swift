//
//  FavoriteRepository.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

protocol FavoriteRepository{
    func fetchFavoriteList(
        completion:@escaping (Result<[RecipeFavorite], Error>) -> Void
    )
    func saveFavorite(
        favorite:RecipeFavorite,
        completion:@escaping (Result<Bool, Error>) -> Void
    )
    func removeFavorite(
        favorite:RecipeFavorite,
        completion:@escaping (Result<Bool, Error>) -> Void
    )
}
