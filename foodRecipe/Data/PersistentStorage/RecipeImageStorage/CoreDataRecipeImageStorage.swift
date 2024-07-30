//
//  CoreDataRecipeImageStorage.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/30.
//

import Foundation
import CoreData

class CoreDataRecipeImageStorage:RecipeImageStorage{

    private let coreDataStorage: CoreDataStorage
    
    init(coreDataStorage: CoreDataStorage) {
        self.coreDataStorage = coreDataStorage
    }

    func fetchRecipeImage(imagePath: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        coreDataStorage.performBackgroundTask{ context in
            do {
                let request: NSFetchRequest = RecipeImageEntity.fetchRequest()
                request.sortDescriptors = [NSSortDescriptor(key: #keyPath(RecipeImageEntity.imagePath),
                                                            ascending: false)]
                request.fetchLimit = 1
                let result = try context.fetch(request)
                
                if result.count > 0{
                    completion(.success(result[0].data))   
                }
                else{
                    completion(.success(nil))
                }
                
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }
    
    func saveRecipeImage(imagePath: String, imageData: Data, completion: @escaping (Result<Data, Error>) -> Void) {
        coreDataStorage.performBackgroundTask{ context in
            do {
                let entity = RecipeImageEntity(imagePath: imagePath, imageData: imageData, insertInto: context)
                try context.save()

                completion(.success(entity.data ?? Data()))
            } catch {
                completion(.failure(CoreDataStorageError.saveError(error)))
            }
        }
    }
}
