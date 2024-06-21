//
//  FetchFavoriteUseCase.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

protocol fetchFavoriteUseCase{
    func excute(
        favorite:RecipeFavorite,
        completion: @escaping (Result<[RecipeFavorite], Error>) -> Void
    )
}

class DefaultfetchFavoriteUseCase:fetchFavoriteUseCase{
    
    private let favoriteRepository:FavoriteRepository
    
    init(favoriteRepository: FavoriteRepository) {
        self.favoriteRepository = favoriteRepository
    }
    
    func excute(favorite:RecipeFavorite, completion: @escaping (Result<[RecipeFavorite], Error>) -> Void) {
        favoriteRepository.fetchFavoriteList(completion: completion)
    }
    
}
