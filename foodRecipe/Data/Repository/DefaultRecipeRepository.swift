//
//  DefaultRecipeRepository.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

final class DefaultRecipeRepository:RecipeRepository{
    func fetchRecipesList(query: RecipeQuery,
                          page: Int) async throws -> RecipePage?{
        
        let perPage = 20
        let requestDTO = RecipeRequestDTO(query: query, page: page, perCount: perPage)
        let endpoint:URLRequest = APIEndpoints.getRecipe(with: requestDTO)
                
        let (data, response) = try await URLSession.shared.data(for: endpoint)
        
        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
            NSLog("sesssiontest servererror")
            return nil
        }
        
        let result = try? JSONDecoder().decode(RecipeResponseDTO.self, from: data)
        
        return result?.toDomain(perPage:perPage)
    }
}
