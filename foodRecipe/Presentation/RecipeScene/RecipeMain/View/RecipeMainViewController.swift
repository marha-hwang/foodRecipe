//
//  ViewController.swift
//  foodRecipe
//
//  Created by haram on 6/15/24.
//

import UIKit

class RecipeMainViewController: UIViewController{
    private var viewModel: RecipeMainViewModel!
    private var recipeMainView:RecipeMainView!
    
    static func create(with viewModel: RecipeMainViewModel) -> RecipeMainViewController {
        
        let vc = RecipeMainViewController()
        vc.viewModel = viewModel
        
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    private func setupViews(){
        view.backgroundColor = .blue
        
        recipeMainView = RecipeMainView(frame: CGRect(x: 0, y: 0,
                                                      width: view.safeAreaLayoutGuide.layoutFrame.width,
                                                      height: 0))
        view.addSubview(recipeMainView)
        recipeMainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        recipeMainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        recipeMainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        recipeMainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        recipeMainView.timeRecommandView.recipeCollection.dataSource = self
        recipeMainView.timeRecommandView.recipeCollection.delegate = self
        
        recipeMainView.weatherRecommandView.recipeCollection.dataSource = self
        recipeMainView.weatherRecommandView.recipeCollection.delegate = self
        
        let item1 = FolderViewItem(name: "한식", image: "logo")
        let item2 = FolderViewItem(name: "중식", image: "logo")
        let item3 = FolderViewItem(name: "양식", image: "logo")
        let item4 = FolderViewItem(name: "일식", image: "logo")
        let item5 = FolderViewItem(name: "찌개", image: "logo")
        let item6 = FolderViewItem(name: "튀김", image: "logo")
        let item7 = FolderViewItem(name: "볶음", image: "logo")
        let item8 = FolderViewItem(name: "구이", image: "logo")
        let item9 = FolderViewItem(name: "양념", image: "logo")
        
        let items = [item1, item2, item3, item4, item5, item6, item7, item8, item9]
        
        recipeMainView.categoryView.backgroundColor = .white
        recipeMainView.categoryView.initForderView(items: items, defaultRow: 2, col: 4){ [weak self] gesture in
//            guard let vc = UIStoryboard(name: "CategoryView", bundle: nil).instantiateViewController(withIdentifier: "categoryview") as? CategoryViewController else { return }
//            vc.nowCategory = gesture.name ?? ""
//            self?.navigationController?.pushViewController(vc, animated: false)
        }
    }
        
}

extension RecipeMainViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeMainItemCell.identifier, for: indexPath) as! RecipeMainItemCell
        
        cell.bind(image: UIImage(named: "logo") ?? UIImage(), recipeName: "햄버거", recipeCategory: "양식", recipeType: "구이", difficultyStar: 3)
        return cell
    }
    
    
}

