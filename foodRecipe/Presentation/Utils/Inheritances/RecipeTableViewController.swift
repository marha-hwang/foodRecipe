//
//  RecipeTableViewController.swift
//  foodRecipe
//
//  Created by h2o on 2024/09/06.
//

import Foundation
import UIKit

protocol RecipeTableViewControllerDelegate{
    func setItemCell()->UITableViewCell.Type
}

class RecipeTableViewController:UITableViewController{
    
    var delegate:RecipeTableViewControllerDelegate?
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
        
        let itemType = delegate?.setItemCell()
        tableView.register(itemType, forCellReuseIdentifier: itemType.reuseIdentifier)        
    }
}

