//
//  RecipeListItemViewModel.swift
//  foodRecipe
//
//  Created by haram on 8/12/24.
//

import Foundation

struct RecipeListItemViewModel{
    let imagePath:String
    let recipeName:String
    let recipeCategory:String
    let recipeType:String
    let difficulty:Int
    
    init(recipe:Recipe) {
        self.imagePath = recipe.main_image
        self.recipeName = recipe.recipe_name
        self.recipeCategory = recipe.recipe_type
        self.recipeType = recipe.cookWay
        self.difficulty = calculateDifficulty(recipe: recipe)
        print(difficulty)
        
        func calculateDifficulty(recipe:Recipe)->Int{
            var star = 5
            
            if recipe.manual[15].description == ""{
                star-=1
            }
            
            if recipe.manual[11].description == ""{
                star-=1
            }
            
            if recipe.manual[7].description == ""{
                star-=1
            }
            
            if recipe.manual[3].description == ""{
                star-=1
            }
            
            return star
            
        }
    }
}
