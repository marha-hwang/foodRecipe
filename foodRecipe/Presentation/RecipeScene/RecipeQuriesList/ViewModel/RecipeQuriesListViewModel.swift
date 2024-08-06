//
//  RecipeQuriesListViewModel.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

struct RecipeQuriesListViewModelActions{
    let showRecipeListByKeyword:(String)->Void
}

protocol RecipeQuriesListViewModelInput{
    func viewDidLoad()
    
    //검색버튼 클릭
    func didSearchByButton(query:String)
    
    //검색어클릭
    func didSearchByQuery(index:Int)
    
    //검색어 삭제
    func didDeleteQuery(index:Int)
    
    //검색어 전체삭제
    func didDeleteAllQuery()
}

protocol RecipeQuriesListViewModelOutput{
    var quriesItems:Observable<[RecipeQueryHistory]> {get}
}

typealias RecipeQuriesListViewModel = RecipeQuriesListViewModelInput&RecipeQuriesListViewModelOutput

final class DefaultRecipeQuriesListViewModel:RecipeQuriesListViewModel{
    
    private let fetchQuriesUseCase:FetchRecentRecipeQuriesUseCase
    private let removeQuriesUseCase:RemoveRecentRecipeQuriesUseCase
    private let actions:RecipeQuriesListViewModelActions?
    
    var quriesItems: Observable<[RecipeQueryHistory]> = Observable([])
    
    init(fetchQuriesUseCase: FetchRecentRecipeQuriesUseCase,
         removeQuriesUseCase: RemoveRecentRecipeQuriesUseCase,
         actions:RecipeQuriesListViewModelActions
    ) {
        self.fetchQuriesUseCase = fetchQuriesUseCase
        self.removeQuriesUseCase = removeQuriesUseCase
        self.actions = actions
    }
    
    private func updateQueryItems(){
        fetchQuriesUseCase.excute(maxCount: 100){ result in
            switch result {
            case .success(let items):
                self.quriesItems.value = items
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func removeQueryItems(queryId:String?){
        removeQuriesUseCase.excute(queryId: queryId, completion: { result in
            switch result {
            case .success(_):
                print("query Deleted")
            case .failure(let error):
                print(error)
            }
        })
    }
    
}

extension DefaultRecipeQuriesListViewModel{
    func viewDidLoad() {
        updateQueryItems()
    }
    
    func didSearchByButton(query: String) {
        actions?.showRecipeListByKeyword(query)
    }
    
    func didSearchByQuery(index: Int) {
        actions?.showRecipeListByKeyword(quriesItems.value[index].recipe_name)
    }
    
    func didDeleteQuery(index: Int) {
        removeQueryItems(queryId: quriesItems.value[index].query_id)
    }
    
    func didDeleteAllQuery() {
        removeQueryItems(queryId: nil)
    }
}
