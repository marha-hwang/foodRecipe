//
//  FetchFavoriteUseCase.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

protocol ChangeFavoriteStatusUseCase{
    func excute(
        recipe:Recipe,
        completion: @escaping (Result<Bool, Error>) -> Void
    )
}

class DefaultChangeFavoriteStatusUseCase:ChangeFavoriteStatusUseCase{
    
    private let favoriteRepository:FavoriteRepository
    
    init(favoriteRepository: FavoriteRepository) {
        self.favoriteRepository = favoriteRepository
    }
    
    func excute(recipe:Recipe, completion: @escaping (Result<Bool, Error>) -> Void) {
        favoriteRepository.fetchFavoriteBySeq(seq:recipe.recipe_seq){ [weak self] result in
            switch result {
            case .success(let recipes):
                if recipes.count > 0{
                    self?.favoriteRepository.removeFavorite(seq: recipe.recipe_seq){ result in
                        switch result{
                        case .success(_):
                            completion(.success(false))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                } 
                else {
                    self?.favoriteRepository.saveFavorite(recipe: recipe){ result in
                        switch result{
                        case .success(_):
                            completion(.success(true))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
