//
//  ViewController.swift
//  foodRecipe
//
//  Created by haram on 6/15/24.
//

import UIKit

class RecipeListViewController: UIViewController, StoryboardInstantiable {

    static func create() -> RecipeListViewController {
        let view = RecipeListViewController.instantiateViewController()
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad")
    }


}

