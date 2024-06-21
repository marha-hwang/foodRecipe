//
//  AddFavoriteUseCase.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

protocol AddFavoriteUseCase{
    func excute(
        favorite:RecipeFavorite,
        completion: @escaping (Result<Bool, Error>) -> Void
    )
}

class DefaultAddFavoriteUseCase:AddFavoriteUseCase{
    
    private let favoriteRepository:FavoriteRepository
    
    init(favoriteRepository: FavoriteRepository) {
        self.favoriteRepository = favoriteRepository
    }
    
    func excute(favorite:RecipeFavorite, completion: @escaping (Result<Bool, Error>) -> Void) {
        favoriteRepository.saveFavorite(favorite: favorite, completion: completion)
    }
    
}
