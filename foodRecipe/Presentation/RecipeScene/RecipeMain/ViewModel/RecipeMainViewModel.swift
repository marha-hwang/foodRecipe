//
//  RecipeMainViewModel.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/22.
//

import Foundation

struct RecipeMainViewModelActions{
    let showRecipeQuriesList:()->Void
    let showRecipeListByCategory:(String)->Void
    let showRecipeDetail:(Recipe)->Void
}

protocol RecipeMainViewModelInput{
    func showRecipeQuriesList()
    func showRecipeListByCategory(category:String)
    func showRecipeDetail(recipe:Recipe)
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
        
        setRecommand()
    }
    
    private func setRecommand(){
        ///동일한 인증키로 api를 동시에 호출하는 경우 인증키 에러가 발생하였음, 따라서 순차적으로 api를 호출하기 위해 아래와 같이 작성
        updateRecommand(recipe_type: "찌개"){ [weak self] page in
            DispatchQueue.main.async{
                self?.weatherRecommandItems.value = page.recpies
            }
            
            self?.updateRecommand(recipe_type: "일품"){ [weak self] page in 
                DispatchQueue.main.async{
                    self?.timeRecommandItems.value = page.recpies
                }
            }
        }
    }
    
    //MARK: private
    private func updateRecommand(recipe_type:String, completion:@escaping(RecipePage)->Void){
        let _ = searchRecipeUsecase.execute(
            requestValue: SearchRecipeUseCaseRequestValue( 
                query: RecipeQuery(
                    recipe_name: nil,
                    recipe_ingredient: nil,
                    recipe_type: recipe_type),
            page: 1)
        ) { result in
                switch result {
                case .success(let page):
                    completion(page)
                case .failure(let error):
                    print(error)
                }
        }
    }
    
}


//MARK: INPUT
extension DefaultRecipeMainViewModel{
    func showRecipeQuriesList() {
        actions?.showRecipeQuriesList()
    }
    
    func showRecipeListByCategory(category: String) {
        actions?.showRecipeListByCategory("")
    }
    
    func showRecipeDetail(recipe: Recipe) {
        actions?.showRecipeDetail(recipe)
    }
}
