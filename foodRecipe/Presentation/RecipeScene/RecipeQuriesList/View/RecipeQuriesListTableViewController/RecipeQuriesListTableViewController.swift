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
        view.backgroundColor = .green
    }
}

extension RecipeQuriesListTableViewController{
    
}
