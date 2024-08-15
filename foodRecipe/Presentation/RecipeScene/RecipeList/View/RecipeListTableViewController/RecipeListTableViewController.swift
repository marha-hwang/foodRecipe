//
//  RecipeListByKeywordTableViewController.swift
//  foodRecipe
//
//  Created by haram on 8/12/24.
//

import Foundation
import UIKit

class RecipeListTableViewController:UITableViewController{
    
    var viewModel:RecipeListViewModel!
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
        view.backgroundColor = .yellow
        
        tableView.register(RecipeListItemCell.self, forCellReuseIdentifier: RecipeListItemCell.reuseIdentifier)
    
    }
}

extension RecipeListTableViewController{
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
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
