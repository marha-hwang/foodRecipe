//
//  RecipeMainViewModel.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/22.
//

import Foundation

struct RecipeMainViewModelActions{
    let showRecipeQuriesList:()->Void
    let showRecipeList:(RecipeListViewType, String)->Void
    let showRecipeDetail:(Recipe)->Void
}

protocol RecipeMainViewModelInput{
    func viewDidLoad()
    func showRecipeQuriesList()
    func showRecipeListByCategory(category:String)
    func showRecipeDetail(recipe:Recipe)
}

protocol RecipeMainViewModelOutput{
    var searchbarPlaceholder:String {get}
    var categoryItems:[FolderViewItem] {get}
    var firsteRcommandTitle:String {get}
    var firstRecommandItems:Observable<[Recipe]> {get}
    var secondRecommandTitle:String {get}
    var secondRecommandItems:Observable<[Recipe]> {get}
}

typealias RecipeMainViewModel = RecipeMainViewModelInput&RecipeMainViewModelOutput

final class DefaultRecipeMainViewModel:RecipeMainViewModel{
    
    private let searchRecipeUsecase:SearchRecipeUseCase
    private let actions:RecipeMainViewModelActions?
    
    // MARK: OUTPUT
    var searchbarPlaceholder: String = "레시피를 검색해보세요"
    var categoryItems: [FolderViewItem] {
        var categoryItems:[FolderViewItem] = []
        Ingredients.data.forEach{ categoryItems.append(FolderViewItem(name: $0.key, image: $0.value)) }
        return categoryItems
    }
    var firsteRcommandTitle: String = ""
    var firstRecommandItems: Observable<[Recipe]> = Observable([])
    var secondRecommandTitle:String = ""
    var secondRecommandItems: Observable<[Recipe]> = Observable([])
    
    init(searchRecipeUsecase: SearchRecipeUseCase, actions: RecipeMainViewModelActions?) {
        self.searchRecipeUsecase = searchRecipeUsecase
        self.actions = actions
    }
    
    private func setRecommand(){
        let firsteRcommandItem = RecommandItems.getRecommandItem()
        let secondRecommandItem = RecommandItems.getRecommandItem()
        firsteRcommandTitle = firsteRcommandItem.title
        secondRecommandTitle = secondRecommandItem.title
        
        ///동일한 인증키로 api를 동시에 호출하는 경우 인증키 에러가 발생하였음, 따라서 순차적으로 api를 호출하기 위해 아래와 같이 작성
        updateRecommand(recipe_name: firsteRcommandItem.foods.randomElement()!){ [weak self] page in
            DispatchQueue.main.async{
                self?.firstRecommandItems.value = page.recpies
            }
            
            self?.updateRecommand(recipe_name: secondRecommandItem.foods.randomElement()!){ [weak self] page in
                DispatchQueue.main.async{
                    self?.secondRecommandItems.value = page.recpies
                }
            }
        }
    }
    
    //MARK: private
    private func updateRecommand(recipe_name:String, completion:@escaping(RecipePage)->Void){
        let _ = searchRecipeUsecase.execute(
            requestValue: SearchRecipeUseCaseRequestValue( 
                query: RecipeQuery(
                    recipe_name: recipe_name,
                    recipe_ingredient: nil,
                    recipe_type: nil),
            page: 1,
            isSave: false)
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
    func viewDidLoad() {
        setRecommand()
    }
    
    func showRecipeQuriesList() {
        actions?.showRecipeQuriesList()
    }
    
    func showRecipeListByCategory(category: String) {
        actions?.showRecipeList(.byCategory, category)
    }
    
    func showRecipeDetail(recipe: Recipe) {
        actions?.showRecipeDetail(recipe)
    }
}
