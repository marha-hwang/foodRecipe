//
//  FavoriteRecipeListTableViewController.swift
//  foodRecipe
//
//  Created by h2o on 2024/09/06.
//

import Foundation
import UIKit

class FavoriteRecipeListTableViewController:UITableViewController{
    
    var viewModel:FavoriteRecipeListViewModel!
    var recipeImagesRepository: RecipeImageRepository?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    private func setupViews(){
        view.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = .init(top: 0, left: 0, bottom: 100, right: 0)        
        tableView.register(RecipeListItemCell.self, forCellReuseIdentifier: RecipeListItemCell.reuseIdentifier)
    }
}

extension FavoriteRecipeListTableViewController{
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return view.frame.width*0.5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recipeItems.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeListItemCell.reuseIdentifier, for: indexPath) as? RecipeListItemCell else {
            assertionFailure("Cannot dequeue reusable cell \(RecipeListItemCell.self) with reuseIdentifier: \(RecipeListItemCell.reuseIdentifier)")
            return UITableViewCell()
        }
        cell.fill(viewModel: RecipeListItemViewModel(recipe: viewModel.recipeItems.value[indexPath.row]), recipeImageRepository: recipeImagesRepository)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        viewModel.didTouchRecipe(index: indexPath.row)
    }
}
