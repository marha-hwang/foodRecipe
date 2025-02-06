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
    func didLoadNextPage()
}

protocol RecipeListViewModelOutput{
    var listType:RecipeListViewType {get}
    var title:Observable<String> {get}
    var recipeItems:Observable<[Recipe]> {get}
    var categoryItems:[String] {get}
    var loading: Observable<Bool> { get }
}

typealias RecipeListViewModel = RecipeListViewModelInput&RecipeListViewModelOutput

final class DefaultRecipeListViewModel:RecipeListViewModel{
    
    private let searchRecipeUseCase:SearchRecipeUseCase
    private let actions:RecipeListViewModelActions?
    var currentPage: Int = 0
    var totalPage: Int = 0
    
    //MARK: OUTPUT
    var listType: RecipeListViewType
    var recipeItems: Observable<[Recipe]> = Observable([])
    var title: Observable<String> = Observable("")
    var categoryItems: [String] = Ingredients.getKeys()
    var loading: Observable<Bool> = Observable(false)
    
    init(listType : RecipeListViewType,
         title:String,
         searchRecipeUseCase: SearchRecipeUseCase,
         actions:RecipeListViewModelActions
    ) {
        self.listType = listType
        self.title.value = title
        self.searchRecipeUseCase = searchRecipeUseCase
        self.actions = actions
    }
    
    private func resetPage(){
        currentPage = 0
        totalPage = 0
        recipeItems.value.removeAll()
    }
    
    private func loadPage(nextPage:Int, category:String?, keyword:String?) async{
        loading.value = true
        
        let page = try? await searchRecipeUseCase.execute(
        requestValue: SearchRecipeUseCaseRequestValue(
            query: RecipeQuery(
                recipe_name: keyword,
                recipe_ingredient: category,
                recipe_type: nil),
        page: nextPage,
        isSave: listType == .byKeyword ? true:false))
        
        let totalCount = page?.total_count ?? 0
        let perCount = page?.perPage ?? 0
        
        self.currentPage = nextPage
        self.totalPage = totalCount/perCount + (totalCount%perCount == 0 ? 0:1)
        DispatchQueue.main.async{
            page?.recpies.forEach{ self.recipeItems.value.append($0) }
        }
        
        loading.value = false
//        let _ = searchRecipeUseCase.execute(
//            requestValue: SearchRecipeUseCaseRequestValue(
//                query: RecipeQuery(
//                    recipe_name: keyword,
//                    recipe_ingredient: category,
//                    recipe_type: nil),
//            page: nextPage,
//            isSave: listType == .byKeyword ? true:false)
//        ) { result in
//                switch result {
//                case .success(let page):
//                    self.currentPage = nextPage
//                    self.totalPage = page.total_count/page.perPage + (page.total_count%page.perPage == 0 ? 0:1)
//                    DispatchQueue.main.async{
//                        page.recpies.forEach{ self.recipeItems.value.append($0) }
//                    }
//                case .failure(let error):
//                    print(error)
//                }
//            self.loading.value = false
//        }
    }
    
    //MARK: async호출 지점구현필요
    private func updatePage(){
//        if listType == .byKeyword{
//            loadPage(nextPage: currentPage+1, category: nil, keyword: title.value)
//        }
//        else if listType == .byCategory{
//            loadPage(nextPage: currentPage+1, category: title.value, keyword: nil)
//        }
    }
    
}

extension DefaultRecipeListViewModel{
    func viewDidLoad() {
        resetPage()
        updatePage()
    }
    
    func didTouchRecipe(index: Int) {
        actions?.showRecipeDetail(recipeItems.value[index])
    }
    
    func didTouchSearchButton() {
        actions?.showRecipeQuriesList()
    }
    
    func didTouchCategory(category: String) {
        title.value = category
        
        resetPage()
        updatePage()
    }
    
    func didLoadNextPage(){
        //totalCount를 이용하여 다음페이지 존재여부 확인필요
        guard currentPage < totalPage else{
            return
        }
        updatePage()
    }
}
