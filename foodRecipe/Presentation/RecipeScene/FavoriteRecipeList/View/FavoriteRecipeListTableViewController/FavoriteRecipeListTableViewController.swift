//
//  FavoriteRecipeListTableViewController.swift
//  foodRecipe
//
//  Created by h2o on 2024/09/06.
//

import Foundation
import UIKit

class FavoriteRecipeListTableViewController:RecipeTableViewController{
    var viewModel:String? //수정필요
    
    override func viewDidLoad() {
        ///super은 RecipeTableViewController임이 확실한가? 맞음
        ///부모클래스에 setupViews라는 함수가 존재하는데 private함수이므로 영향도가 없는것이 확실한가?맞음
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews(){
        tableView.register(RecipeListItemCell.self, forCellReuseIdentifier: RecipeListItemCell.reuseIdentifier)        
    }
}

extension FavoriteRecipeListTableViewController{
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return view.frame.width*0.5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return viewModel.recipeItems.value.count
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeListItemCell.reuseIdentifier, for: indexPath) as? RecipeListItemCell else {
            assertionFailure("Cannot dequeue reusable cell \(RecipeListItemCell.self) with reuseIdentifier: \(RecipeListItemCell.reuseIdentifier)")
            return UITableViewCell()
        }
//        cell.fill(viewModel: RecipeListItemViewModel(recipe: viewModel.recipeItems.value[indexPath.row]), recipeImageRepository: recipeImagesRepository)
//        
//        //모든 페이지를 한번에 로드하지 않고 페이지가 끝나는 시점에 로드하기 위한코드
//        if indexPath.row == viewModel.recipeItems.value.count - 1 {
//            viewModel.didLoadNextPage()
//        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
//        viewModel.didTouchRecipe(index: indexPath.row)
    }
}
