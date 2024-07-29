//
//  RecipeMainCollectionViewController.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/23.
//

import Foundation
import UIKit

class RecipeMainCollectionViewController:UICollectionViewController{
    
    var viewModel: RecipeMainViewModel!
    var items:[Recipe]?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 300)
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func reload(){
        collectionView.reloadData()
    }
    
    private func setupViews(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .orange
        collectionView.register(RecipeMainItemCell.self, forCellWithReuseIdentifier: RecipeMainItemCell.reuseIdentifier)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)        
    }
}

extension RecipeMainCollectionViewController{    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecipeMainItemCell.reuseIdentifier,
            for: indexPath
        ) as? RecipeMainItemCell else {
            assertionFailure("Cannot dequeue reusable cell \(RecipeMainItemCell.self) with reuseIdentifier: \(RecipeMainItemCell.reuseIdentifier)")
            return UICollectionViewCell()
        }
        cell.fill(viewModel: RecipeMainItemViewModel(recipe: items![indexPath.row]))

        return cell
    }
}
