//
//  DefaultRecipeRepository.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

final class DefaultRecipeRepository:RecipeRepository{
    func fetchRecipesList(query: RecipeQuery,
                          page: Int,
                          completion: @escaping(Result<RecipePage, Error>) -> Void) -> Cancellable? {
        
        
        let requestDTO = RecipeRequestDTO(query: query, page: page, perCount: 10)
        let endpoint:URLRequest = APIEndpoints.getRecipe(with: requestDTO)
        
        let task = RepositoryTask()
        task.networkTask = URLSession.shared.dataTask(with: endpoint) { data, response, error in
            if error != nil {
                NSLog("sesssiontest error")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                NSLog("sesssiontest servererror")
                return
            }
            
            guard let _data = data else{
                NSLog("Data is Null")
                return
            }
            
            
            //print(String(decoding: _data, as: UTF8.self))
                        
            let result = try? JSONDecoder().decode(RecipeResponseDTO.self, from: _data)
            if let _result = result{
                completion(.success(_result.toDomain()))
            }
            else {
                completion(.failure(DataError.ParsingError))
            }
        }
        task.networkTask?.resume()
        
        return task
    }
}
