//
//  RecipeImageEntity.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/30.
//

import Foundation
import CoreData

extension RecipeImageEntity {
    convenience init(imagePath:String, imageData:Data, insertInto context: NSManagedObjectContext) {
        self.init(context: context)

        self.imagePath = imagePath
        self.data = imageData
    }
}
