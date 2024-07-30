//
//  DefaultRecipeImageRepository.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

final class DefaultRecipeImagesRepository:RecipeImageRepository {
    
    private var recipeImageStorage:RecipeImageStorage
    private var recipeImageCache:RecipeImageCache
    
    init(recipeImageStorage:RecipeImageStorage, recipeImageCache:RecipeImageCache){
        self.recipeImageStorage = recipeImageStorage
        self.recipeImageCache = recipeImageCache
    }
    
    func fetchImage(
        with imagePath: String,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
            
            //캐시에 이미지가 존재하는 경우
            if let data = recipeImageCache.getImageData(imagePath: imagePath) {
                completion(.success(data))
                print("cache")
                return
            }
        
            recipeImageStorage.fetchRecipeImage(imagePath: imagePath){ [weak self] result in
                switch result{
                case .success(let data):
                    //coreData에 이미지가 존재하는 경우
                    if let imageData = data{
                        completion(.success(imageData))
                        self?.recipeImageCache.setImageData(imagePath: imagePath, data: imageData)
                        print("coreData")
                        return
                    }
                    
                    //이미지를 처음 로딩하는 경우
                    let endpoint = URLRequest(url: URL(string: imagePath)!)
                    let task = RepositoryTask()
                    task.networkTask = URLSession.shared.dataTask(with: endpoint) { data, response, error in
                        if error != nil {
                            completion(.failure(DataError.NotFoundError))
                            return
                        }
                        guard let httpResponse = response as? HTTPURLResponse,
                            (200...299).contains(httpResponse.statusCode) else {
                            completion(.failure(DataError.NotFoundError))
                            return
                        }
                        
                        guard let imageData = data else{
                            completion(.failure(DataError.NotFoundError))
                            return
                        }
                        
                        self?.recipeImageStorage.saveRecipeImage(imagePath: imagePath,
                                                           imageData: imageData){ [weak self] result in
                            switch result{
                            case .success(let data):
                                completion(.success(data))
                                print("network")
                                // cache에 저장
                                self?.recipeImageCache.setImageData(imagePath: imagePath, data: data)
                            case .failure(let error):
                                completion(.failure(error))
                            }
                        }

                    }
                    task.networkTask?.resume()
                    
                case .failure(let error):
                    completion(.failure(error))
                }

            }
        
    }
}

