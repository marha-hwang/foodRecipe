//
//  RecipeMainViewModel.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/22.
//

import Foundation

struct RecipeMainViewModelActions{
    let showRecipeQuriesList:()->Void
    let showRecipeListByKeyword:(String)->Void
    let showRecipeListByCategory:(String)->Void
    let showRecipeDetail:(Recipe)->Void
}

protocol RecipeMainViewModelInput{
    func showRecipeQuriesList()
    func showRecipeListByKeyword(keyword:String)
    func showRecipeListByCategory(category:String)
    func showRecipeDetail(recipe:Recipe)
    func openCategory()
    func closeCategory()
}

protocol RecipeMainViewModelOutput{
    var searchbarPlaceholder:String {get}
    var categoryItems:[FolderViewItem] {get}
    var weatherRecommandTitle:Observable<String> {get}
    var weatherRecommandItems:Observable<[Recipe]> {get}
    var timeRecommandTitle:String {get}
    var timeRecommandItems:Observable<[Recipe]> {get}
}

typealias RecipeMainViewModel = RecipeMainViewModelInput&RecipeMainViewModelOutput

final class DefaultRecipeMainViewModel:RecipeMainViewModel{
    
    private let searchRecipeUsecase:SearchRecipeUseCase
    private let actions:RecipeMainViewModelActions?
    
    // MARK: OUTPUT
    var searchbarPlaceholder: String = "레시피를 검색해보세요"
    var categoryItems: [FolderViewItem] = [
        FolderViewItem(name: "한식", image: "logo"),
        FolderViewItem(name: "중식", image: "logo"),
        FolderViewItem(name: "양식", image: "logo"),
        FolderViewItem(name: "일식", image: "logo"),
        FolderViewItem(name: "찌개", image: "logo"),
        FolderViewItem(name: "튀김", image: "logo"),
        FolderViewItem(name: "볶음", image: "logo"),
        FolderViewItem(name: "구이", image: "logo"),
        FolderViewItem(name: "양념", image: "logo"),
        FolderViewItem(name: "양념", image: "logo"),
        FolderViewItem(name: "양념", image: "logo"),
        FolderViewItem(name: "양념", image: "logo"),
        FolderViewItem(name: "양념", image: "logo"),
    ]
    var weatherRecommandTitle: Observable<String> = Observable("비오는날 어울리는 음식을 추천합니다")
    var weatherRecommandItems: Observable<[Recipe]> = Observable([])
    var timeRecommandTitle: String = "브런치에 어울리는 음식을 추천합니다."
    var timeRecommandItems: Observable<[Recipe]> = Observable([])
    
    init(searchRecipeUsecase: SearchRecipeUseCase, actions: RecipeMainViewModelActions?) {
        self.searchRecipeUsecase = searchRecipeUsecase
        self.actions = actions
    }
    
}


//MARK: INPUT
extension DefaultRecipeMainViewModel{
    func showRecipeQuriesList() {
        
    }
    
    func showRecipeListByKeyword(keyword: String) {
    
    }
    
    func showRecipeListByCategory(category: String) {
        print(category)
    }
    
    func showRecipeDetail(recipe: Recipe) {
        
    }
    
    func openCategory() {
        
    }
    
    func closeCategory() {
        
    }
}
