//
//  FoodType.swift
//  foodRecipe
//
//  Created by haram on 8/19/24.
//

import Foundation

class Ingredients{
    static let data:[String:String] = [
        "우유":"milk",
        "달걀":"egg",
        "새우":"shrimp",
        "두부":"tofu",
        "밀가루":"flour",
        "쌀":"rice",
        "소고기":"beef",
        "닭고기":"chicken",
        "돼지고기":"pork",
        "오이":"cucumber",
        "사과":"apple",
        "토마토":"tomato",
        
        
    ]
    private init(){ }
    
    static func getKeys()->[String]{
        var keys:[String] = []
        data.forEach{keys.append($0.key)}
        
        return keys.sorted{$0 > $1}
    }
}
