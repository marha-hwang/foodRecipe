//
//  RecipeListByKeywordViewModel.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/22.
//

import Foundation

enum RecipeListViewType{
    case byKeyword
    case byCategory
}

struct RecipeListViewModelActions{
    let showRecipeDetail:(Recipe)->Void
    let showRecipeQuriesList:()->Void
}

protocol RecipeListViewModelInput{
    func viewDidLoad()
    func didTouchSearchButton()
    func didTouchCategory(category:String)
    func didTouchRecipe(index:Int)
}

protocol RecipeListViewModelOutput{
    var listType:RecipeListViewType {get}
    var title:String {get}
    var recipeItems:Observable<[Recipe]> {get}
    var categoryItems:[String] {get}
}

typealias RecipeListViewModel = RecipeListViewModelInput&RecipeListViewModelOutput

final class DefaultRecipeListViewModel:RecipeListViewModel{
    
    private let searchRecipeUseCase:SearchRecipeUseCase
    private let actions:RecipeListViewModelActions?
    
    var listType: RecipeListViewType
    var recipeItems: Observable<[Recipe]> = Observable([])
    var title: String = ""
    var categoryItems: [String] = []
    
    init(listType : RecipeListViewType,
         title:String,
         searchRecipeUseCase: SearchRecipeUseCase,
         actions:RecipeListViewModelActions
    ) {
        self.listType = listType
        self.title = title
        self.searchRecipeUseCase = searchRecipeUseCase
        self.actions = actions
    }
    
    private func updateRecipeItems(page:Int, category:String?, keyword:String?){
        let _ = searchRecipeUseCase.execute(
            requestValue: SearchRecipeUseCaseRequestValue(
                query: RecipeQuery(
                    recipe_name: keyword,
                    recipe_ingredient: nil,
                    recipe_type: category),
            page: page,
            isSave: category != nil ? false:true)
        ) { result in
                switch result {
                case .success(let page):
                    DispatchQueue.main.async{
                        self.recipeItems.value = page.recpies
                    }
                case .failure(let error):
                    print(error)
                }
        }
    }
    
}

extension DefaultRecipeListViewModel{
    func viewDidLoad() {
        if listType == .byKeyword{
            updateRecipeItems(page: 1, category: nil, keyword: title)
        }
        else if listType == .byCategory{
            updateRecipeItems(page: 1, category: title, keyword: nil)
        }
    }
    
    func didTouchRecipe(index: Int) {
        actions?.showRecipeDetail(recipeItems.value[index])
    }
    
    func didTouchSearchButton() {
        actions?.showRecipeQuriesList()
    }
    
    func didTouchCategory(category: String) {
        updateRecipeItems(page: 1, category: category, keyword: nil)
    }
}
