//
//  CoreDataStorage.swift
//  foodRecipe
//
//  Created by h2o on 2024/06/24.
//

import Foundation
import CoreData

final class CoreDataStorage : NSObject {
    
    private static let _shared = CoreDataStorage()
    
    @objc public static var shared : CoreDataStorage {
        return _shared
    }
    
    // MARK: 코어데이터
    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "a.test1" in the application's documents Application Support directory.
            let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        
        let SAIBundle = Bundle(identifier: "com.aaaa.bbbb")
        
        let modelURL = SAIBundle!.url(forResource: "CoreDataStorage", withExtension: ".momd")!
        
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
    
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    
        let urlstr = (self.applicationDocumentsDirectory.appendingPathComponent("MSGVo").absoluteString)
        let url = URL(string: urlstr)
        
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)");
            abort()
        }
        return coordinator
    }()
    
   lazy var managedObjectContext: NSManagedObjectContext = {

        let coordinator = self.persistentStoreCoordinator
//        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)

        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
          
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)");
                abort()
            }
        }
    }
}
