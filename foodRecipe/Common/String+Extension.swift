//
//  String+Extension.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/30.
//

import Foundation

extension String{

    func getChar(_ index:Int) -> Character{
    
    let i = self.index(self.startIndex, offsetBy: index)
    
    return self[i]
    
    }
    func getString(_ start:Int, _ end:Int) -> String{
        let start = self.index(self.startIndex, offsetBy: start)
        let end = self.index(self.startIndex, offsetBy: end)
    
        return String(self[start..<end])
    }
}

extension String{

    func createRandomStr(length: Int) -> String {
        let str = (0 ..< length).map{ _ in self.randomElement()! }
        return String(str)
    }
        
    
}
