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
        
        let requestDTO = RecipeRequestDTO(recipe_name: query.recipe_name ?? "",
                                          recipe_ingredient: query.recipe_ingredient ?? "",
                                          recipe_type: query.recipe_type ?? "",
                                          page: page)
        let task = RepositoryTask()
        let endpoint = APIEndpoints.getRecipe()
        
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
            
            let string = String(data: data!, encoding: .utf8)
            NSLog("sessiontest \(string ?? "")")
            let page = try? JSONDecoder().decode(RecipeResponseDTO, from: data!) as RecipeResponseDTO
            completion(.success(page?.todomain()!))
        }
        
        return task
    }
}
