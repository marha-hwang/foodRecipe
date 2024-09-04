//
//  FavoriteRepository.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

protocol FavoriteRepository{
    func fetchFavoriteList(
        completion:@escaping (Result<[Recipe], Error>) -> Void
    )
    
    func fetchFavoriteBySeq(
        seq:String,
        completion:@escaping (Result<[Recipe], Error>) -> Void
    )
    
    func saveFavorite(
        recipe:Recipe,
        completion:@escaping (Result<Bool, Error>) -> Void
    )
    func removeFavorite(
        seq:String,
        completion:@escaping (Result<Bool, Error>) -> Void
    )
}
