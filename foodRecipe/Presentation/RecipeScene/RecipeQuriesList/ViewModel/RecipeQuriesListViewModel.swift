//
//  RecipeQuriesListViewModel.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

struct RecipeQuriesListViewModelActions{
    let showRecipeList:(RecipeListViewType, String)->Void
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
    var allRemoveButtonText:String {get}
    var queryTableTitle:String {get}
}

typealias RecipeQuriesListViewModel = RecipeQuriesListViewModelInput&RecipeQuriesListViewModelOutput

final class DefaultRecipeQuriesListViewModel:RecipeQuriesListViewModel{
    
    private let fetchQuriesUseCase:FetchRecentRecipeQuriesUseCase
    private let removeQuriesUseCase:RemoveRecentRecipeQuriesUseCase
    private let actions:RecipeQuriesListViewModelActions?
    
    var quriesItems: Observable<[RecipeQueryHistory]> = Observable([])
    var allRemoveButtonText: String = "전체삭제"
    var queryTableTitle:String = "최근 검색어"
    
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
                
                //임시 데이터 추가 코드
                var temp:[RecipeQueryHistory] = []
                temp.append(RecipeQueryHistory(query_id: "12345", recipe_name: "짜장", reg_date: Date()))
                temp.append(RecipeQueryHistory(query_id: "12345", recipe_name: "짜장", reg_date: Date()))
                temp.append(RecipeQueryHistory(query_id: "12345", recipe_name: "짜장", reg_date: Date()))
                temp.append(RecipeQueryHistory(query_id: "12345", recipe_name: "짜장", reg_date: Date()))
                temp.append(RecipeQueryHistory(query_id: "12345", recipe_name: "짜장", reg_date: Date()))
                temp.append(RecipeQueryHistory(query_id: "12345", recipe_name: "짜장", reg_date: Date()))
                temp.append(RecipeQueryHistory(query_id: "12345", recipe_name: "짜장", reg_date: Date()))
                temp.append(RecipeQueryHistory(query_id: "12345", recipe_name: "짜장", reg_date: Date()))
                temp.append(RecipeQueryHistory(query_id: "12345", recipe_name: "짜장", reg_date: Date()))
                temp.append(RecipeQueryHistory(query_id: "12345", recipe_name: "짜장", reg_date: Date()))
                temp.append(RecipeQueryHistory(query_id: "12345", recipe_name: "짜장", reg_date: Date()))
                temp.append(RecipeQueryHistory(query_id: "12345", recipe_name: "짜장", reg_date: Date()))
                temp.append(RecipeQueryHistory(query_id: "12345", recipe_name: "짜장", reg_date: Date()))
                temp.append(RecipeQueryHistory(query_id: "12345", recipe_name: "짜장", reg_date: Date()))
                temp.append(RecipeQueryHistory(query_id: "12345", recipe_name: "짜장", reg_date: Date()))
                temp.append(RecipeQueryHistory(query_id: "12345", recipe_name: "짜장", reg_date: Date()))
                temp.append(RecipeQueryHistory(query_id: "12345", recipe_name: "짜장", reg_date: Date()))
                temp.append(RecipeQueryHistory(query_id: "12345", recipe_name: "짜장", reg_date: Date()))
                temp.append(RecipeQueryHistory(query_id: "12345", recipe_name: "짜장", reg_date: Date()))
                temp.append(RecipeQueryHistory(query_id: "12345", recipe_name: "짜장", reg_date: Date()))
                temp.append(RecipeQueryHistory(query_id: "12345", recipe_name: "짜장", reg_date: Date()))

                
                self.quriesItems.value = temp
                
                
                
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
        actions?.showRecipeList(.byKeyword, query)
    }
    
    func didSearchByQuery(index: Int) {
        actions?.showRecipeList(.byKeyword, quriesItems.value[index].recipe_name)
    }
    
    func didDeleteQuery(index: Int) {
        removeQueryItems(queryId: quriesItems.value[index].query_id)
    }
    
    func didDeleteAllQuery() {
        print("didDeleteAllQuery")
        removeQueryItems(queryId: nil)
    }
}
