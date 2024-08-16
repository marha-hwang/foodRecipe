//
//  RecipeQuriesListTableViewController.swift
//  foodRecipe
//
//  Created by h2o on 2024/08/07.
//

import Foundation
import UIKit

class RecipeQuriesListTableViewController:UITableViewController{
    
    var viewModel:RecipeQuriesListViewModel!
    
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
        
        tableView.register(RecipeQuriesListItemCell.self, forCellReuseIdentifier: RecipeQuriesListItemCell.reuseIdentifier)
    
    }
}

extension RecipeQuriesListTableViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.quriesItems.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeQuriesListItemCell.reuseIdentifier, for: indexPath) as? RecipeQuriesListItemCell else {
            assertionFailure("Cannot dequeue reusable cell \(RecipeQuriesListItemCell.self) with reuseIdentifier: \(RecipeQuriesListItemCell.reuseIdentifier)")
            return UITableViewCell()
        }
        
        let actions = RecipeQuriesListItemViewModelActions(didDeleteQuery: viewModel.didDeleteQuery(queryId:))
        cell.fill(viewModel: RecipeQuriesListItemViewModel(recipeQuery: viewModel.quriesItems.value[indexPath.row], actions: actions))

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        viewModel.didSearchByQuery(index: indexPath.row)
    }
}
