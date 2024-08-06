//
//  CoreDataResponseStorage.swift
//  foodRecipe
//
//  Created by h2o on 2024/06/24.
//

import Foundation
import CoreData

class CoreDataRecipeQueryStorage:RecipeQueryStorage{
    
    private let coreDataStorage: CoreDataStorage
    
    init(coreDataStorage: CoreDataStorage) {
        self.coreDataStorage = coreDataStorage
    }
    
    func fetchRecentsQueries(maxCount: Int, completion: @escaping (Result<[RecipeQueryHistory], Error>) -> Void) {
        coreDataStorage.performBackgroundTask{ context in
            do {
                let request: NSFetchRequest = RecipeQueryEntity.fetchRequest()
                request.sortDescriptors = [NSSortDescriptor(key: #keyPath(RecipeQueryEntity.reg_date),
                                                            ascending: false)]
                request.fetchLimit = maxCount
                let result = try context.fetch(request).map { $0.toDomain() }

                completion(.success(result))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }
    
    func saveRecentQuery(query: RecipeQueryHistory, completion: @escaping (Result<RecipeQueryHistory, Error>) -> Void) {
        coreDataStorage.performBackgroundTask{ context in
            do {
                let entity = RecipeQueryEntity(recipeQuery: query, insertInto: context)
                try context.save()

                completion(.success(entity.toDomain()))
            } catch {
                completion(.failure(CoreDataStorageError.saveError(error)))
            }
        }
    }
    
    func removeRecentQuery(queryId:String?, completion: @escaping (Result<Bool, Error>) -> Void) {
        coreDataStorage.performBackgroundTask{ context in
            do
            {
                let request: NSFetchRequest = RecipeQueryEntity.fetchRequest()
                
                if let _queryId = queryId{
                    let predicate = NSPredicate(format: "%K == %@", #keyPath(RecipeQueryEntity.queryId), _queryId)
                    request.predicate = predicate
                }
                
                let result = try context.fetch(request)
                result.forEach{ context.delete($0) }
                try context.save()
                
                completion(.success(true))
            } catch {
                completion(.failure(CoreDataStorageError.saveError(error)))
                completion(.success(false))
            }
        }
    }
}
