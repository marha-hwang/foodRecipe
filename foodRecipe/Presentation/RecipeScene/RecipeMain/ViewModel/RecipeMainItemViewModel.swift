//
//  RecipeMainItemViewModel.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/23.
//

import Foundation

struct RecipeMainItemViewModel{
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
        
        func calculateDifficulty(recipe:Recipe)->Int{
            var star = 5
            
            if recipe.manual20 != ""{
                return star
            }
            
            if recipe.manual15 != ""{
                star-=1
                return star 
            }
            
            if recipe.manual10 != ""{
                star-=1
                return star 
            }
            
            if recipe.manual5 != ""{
                star-=1
                return star 
            }
            
            star-=1
            return star 
            
        }
    }
}
