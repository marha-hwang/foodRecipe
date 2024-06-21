//
//  RemoveFavoriteUseCase.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

protocol RemoveFavoriteUseCase{
    func excute(
        favorite:RecipeFavorite,
        completion: @escaping (Result<Bool, Error>) -> Void
    )
}

class DefaultARemoveFavoriteUseCase:RemoveFavoriteUseCase{
    
    private let favoriteRepository:FavoriteRepository
    
    init(favoriteRepository: FavoriteRepository) {
        self.favoriteRepository = favoriteRepository
    }
    
    func excute(favorite:RecipeFavorite, completion: @escaping (Result<Bool, Error>) -> Void) {
        favoriteRepository.removeFavorite(favorite: favorite, completion: completion)
    }
    
}
