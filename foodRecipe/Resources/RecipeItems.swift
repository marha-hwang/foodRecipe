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

class RecommandItems{
    
    static let RecommandItems:[RecommandItem] = [
        RecommandItem(title: "집에서 혼자 시간을 보낼 때", foods: ["볶음밥", "스프"]),
        RecommandItem(title: "친구들과의 모임", foods: ["피자"]),
        RecommandItem(title: "특별한 날의 기념일", foods: ["스테이크", "케이크"]),
        RecommandItem(title: "아침에 활기차게 시작하고 싶을 때", foods: ["샌드위치"]),
        RecommandItem(title: "건강한 식사를 원할 때", foods: ["샐러드"]),
    ]
    
    static func getRecommandItem()->RecommandItem{
        return RecommandItems.randomElement()!
    }
}

struct RecommandItem{
    let title:String
    let foods:[String]
}
