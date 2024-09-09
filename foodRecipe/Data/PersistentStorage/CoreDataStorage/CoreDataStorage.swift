//
//  CoreDataStorage.swift
//  foodRecipe
//
//  Created by h2o on 2024/06/24.
//

import Foundation
import CoreData

enum CoreDataStorageError: Error {
    case readError(Error)
    case saveError(Error)
    case deleteError(Error)
}

final class CoreDataStorage : NSObject {
    
    private static let _shared = CoreDataStorage()
    
    @objc public static var shared : CoreDataStorage {
        return _shared
    }
    
    private override init(){ }
    
    // MARK: 코어데이터 세팅
    private lazy var _model:NSManagedObjectModel? = {
        guard let modelURL = Bundle.main.url(forResource: "CoreDataStorage",
                                             withExtension: "momd") else {
            fatalError("Failed to find data model")
        }
        // model의 url을 가지고 NSManagedObjectModel인스턴스를 생성
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to create model from file: \(modelURL)")
        }
        
        return model
    }()
    
    private lazy var _coordinator:NSPersistentStoreCoordinator? = {
        
        // model의 url을 가지고 NSManagedObjectModel인스턴스를 생성
        guard let model = _model else {
            fatalError("Failed to create model from file")
        }
        
        // 데이터 파일이 저장될 디렉터리를 구함 
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory,
                                                        in: .userDomainMask).last
        // 데이터가 저장이 될 url을 구함
        guard let storeURL = URL(string: "DataModel.sqlite",
                                 relativeTo: documentDirectoryURL) else {
            fatalError("Failed to create store URL")
        }

        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)        
        do {
            // Add the store to the coordinator.
            _ = try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        } catch {
            fatalError("Failed to add persistent store: \(error.localizedDescription)")
        }
        
        return coordinator
    }()
    
    private lazy var _context: NSManagedObjectContext? = {
       
        guard let coordinator = _coordinator else{
            fatalError("Failed to create NSPersistentStoreCoordinator")
        }

       let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
       context.persistentStoreCoordinator = coordinator
       return context
       
    }()
    
    ///해당 함수의 목적
    ///1. private로 지정된 context에 접근할 수 있도록 함
    ///2. 코어데이터는 기본적으로 메인쓰레드에서 동작함 따라서 global.async를 사용하면 비동기적으로 처리가 가능할줄알았음
    ///그러나...... 에러가 발생하였고 발생 원인은 아래와 같음
    ///
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        guard let context = _context else{
            return
        }
        
        context.perform{block(context)}
//        
//        DispatchQueue.global().async{
//            block(context)
//        }
    }
    
    func saveContext () {
        guard let context = _context else{
            return
        }
        if context.hasChanges {
            do {
                try context.save()
            } catch {
          
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)");
                abort()
            }
        }
    }
    
    
}
