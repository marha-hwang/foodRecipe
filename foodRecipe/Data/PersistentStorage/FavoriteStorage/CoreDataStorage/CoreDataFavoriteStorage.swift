//
//  CoreDataFavoriteStorage.swift
//  foodRecipe
//
//  Created by haram on 7/1/24.
//

import Foundation
import CoreData

class CoreDataFavoriteStorage:FavoriteStorage{
    
    private var coreDataStorage:CoreDataStorage
    
    init(coreDataStorage: CoreDataStorage) {
        self.coreDataStorage = coreDataStorage
    }
    
    func fetchFavoriteRecipe(seq:String?, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        coreDataStorage.performBackgroundTask{ context in
            do {
                let request: NSFetchRequest = RecipeFavoriteEntity.fetchRequest()
      
                if let _seq = seq{
                    let predicate = NSPredicate(format: "%K == %@", #keyPath(RecipeFavoriteEntity.recipe_seq), _seq)
                    request.predicate = predicate
                }
                
                let result = try context.fetch(request).map { $0.toDomain() }

                completion(.success(result))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }
    
    func saveFavoriteRecipe(recipe: Recipe, completion: @escaping (Result<Bool, Error>) -> Void) {
        coreDataStorage.performBackgroundTask{ context in
            do {
                let entity = RecipeFavoriteEntity(recipe: recipe, insertInto: context)
                try context.save()

                completion(.success(true))
            } catch {
                completion(.failure(CoreDataStorageError.saveError(error)))
            }
        }
    } 
    
    func removeFavoriteRecipe(seq:String, completion: @escaping (Result<Bool, Error>) -> Void) {
        coreDataStorage.performBackgroundTask{ context in
            do
            {
                let request: NSFetchRequest = RecipeFavoriteEntity.fetchRequest()
                request.sortDescriptors = [NSSortDescriptor(key: #keyPath(RecipeFavoriteEntity.recipe_seq),
                                                            ascending: false)]
                
                let predicate = NSPredicate(format: "%K == %@", #keyPath(RecipeFavoriteEntity.recipe_seq), seq)
                request.predicate = predicate
                
                let result = try context.fetch(request)
                
                context.delete(result[0])
                try context.save()
                completion(.success(true))
                
            } catch {
                completion(.failure(CoreDataStorageError.saveError(error)))
                completion(.success(false))
            }
        }
    }
    
}
