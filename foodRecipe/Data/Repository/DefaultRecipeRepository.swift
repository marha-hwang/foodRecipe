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
        
        let task = RepositoryTask()
        
        let url = URL(string: "http://openapi.foodsafetykorea.go.kr/api/40302191c0db49ad91c7/COOKRCP01/json/1/5")
        let endpoint = URLRequest(url: url!)
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
            
            //Response에 api 결과를 담고, todomain함수를 사용하여 Entity형식으로 변환해야한다.
            let temp = try! JSONDecoder().decode(RecipeResponseDTO.self, from: data!)
            print(temp.COOKRCP01.total_count)
            // completion(.success(page?.todomain()!))

        }
        task.networkTask?.resume()
        
        return task
    }
}
