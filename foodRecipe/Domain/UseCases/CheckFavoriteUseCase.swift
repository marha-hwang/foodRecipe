//
//  FetchFavoriteUseCase.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

protocol CheckFavoriteUseCase{
    func excute(
        seq:String,
        completion: @escaping (Result<Bool, Error>) -> Void
    )
}

class DefaultCheckFavoriteUseCase:CheckFavoriteUseCase{
    
    private let favoriteRepository:FavoriteRepository
    
    init(favoriteRepository: FavoriteRepository) {
        self.favoriteRepository = favoriteRepository
    }
    
    func excute(seq:String, completion: @escaping (Result<Bool, Error>) -> Void) {
        favoriteRepository.fetchFavoriteBySeq(seq: seq){ result in
            switch result {
            case .success(let recipes):
                if recipes.count > 0{
                    completion(.success(true))
                } 
                else {
                    completion(.success(false))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
