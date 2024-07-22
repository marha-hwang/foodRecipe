//
//  ViewController.swift
//  foodRecipe
//
//  Created by haram on 6/15/24.
//

import UIKit

class RecipeMainViewController: UIViewController {
    private var viewModel: RecipeMainViewModel!
    
    static func create(
        with viewModel: RecipeMainViewModel,
        posterImagesRepository: PosterImagesRepository?
    ) -> RecipeMainViewController {
        let view = RecipeMainViewController()
        view.viewModel = viewModel
        view.posterImagesRepository = posterImagesRepository
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad")
    }


}

