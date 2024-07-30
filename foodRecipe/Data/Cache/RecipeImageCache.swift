//
//  RecipeImageCache.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/30.
//

import Foundation

final class RecipeImageCache : NSObject {
    
    private let cache = NSCache<NSString, NSData>()
    
    private static let _shared = RecipeImageCache()
    
    @objc public static var shared : RecipeImageCache {
        return _shared
    }
    
    private override init(){ }
    
    public func setImageData(imagePath:String, data:Data){
        cache.setObject(data as NSData, forKey: imagePath as NSString)
    }
    
    public func getImageData(imagePath:String) -> Data?{
        cache.object(forKey: imagePath as NSString) as? Data
    }
    
}
