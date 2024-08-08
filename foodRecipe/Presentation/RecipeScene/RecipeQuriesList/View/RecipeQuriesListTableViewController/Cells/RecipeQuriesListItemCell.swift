//
//  RecipeQuriesListItemCell.swift
//  foodRecipe
//
//  Created by h2o on 2024/08/07.
//

import Foundation
import UIKit

class RecipeQuriesListItemCell:UITableViewCell{
    static let reuseIdentifier = String(describing: RecipeQuriesListItemCell.self)
    private var viewModel: RecipeQuriesListItemViewModel!
    
    lazy var searchText:UILabel = {
        let searchText = UILabel()
        searchText.translatesAutoresizingMaskIntoConstraints = false
        searchText.textAlignment = .center
        searchText.font = UIFont.systemFont(ofSize: 13)
        
        return searchText
    }()
    
    lazy var dateText:UILabel = {
        let dateText = UILabel()
        dateText.translatesAutoresizingMaskIntoConstraints = false
        dateText.textAlignment = .left
        dateText.font = UIFont.systemFont(ofSize: 13)
        
        return dateText
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        contentView.addSubview(outerView)
        
        outerView.widthAnchor.constraint(equalToConstant: contentView.frame.width).isActive = true
        outerView.heightAnchor.constraint(equalToConstant: contentView.frame.height).isActive = true
        outerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        outerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true

    }
    
    public func fill(viewModel:RecipeQuriesListItemViewModel){
        self.viewModel = viewModel
        
        searchText.text = viewModel.keyword
        dateText.text = viewModel.reg_date
    }
    
    lazy var outerView:UIStackView = {
        let outerView = UIStackView()
        outerView.translatesAutoresizingMaskIntoConstraints = false
        outerView.axis = .horizontal
        outerView.alignment = .fill
        outerView.distribution = .fillProportionally
        
        var clockImage:UIImageView = {
            let clockImage = UIImageView(image: UIImage(systemName: "clock"))
            let image = UIImage(systemName: "clock")
            clockImage.translatesAutoresizingMaskIntoConstraints = false
            clockImage.contentMode = .center
            clockImage.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            clockImage.tintColor = .lightGray
            return clockImage
        }()
        
        var deleteImage:UIImageView = {
            let deleteImage = UIImageView(image: UIImage(systemName: "minus.circle"))
            deleteImage.translatesAutoresizingMaskIntoConstraints = false
            deleteImage.contentMode = .center
            deleteImage.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            deleteImage.tintColor = .lightGray
            return deleteImage
        }()
        
        outerView.addArrangedSubview(clockImage)
        outerView.addArrangedSubview(dateText)
        outerView.addArrangedSubview(searchText)
        outerView.addArrangedSubview(deleteImage)
        
        clockImage.widthAnchor.constraint(equalToConstant: contentView.frame.width*0.2).isActive = true
        searchText.widthAnchor.constraint(equalToConstant: contentView.frame.width*0.4).isActive = true
        dateText.widthAnchor.constraint(equalToConstant: contentView.frame.width*0.2).isActive = true
        deleteImage.widthAnchor.constraint(equalToConstant: contentView.frame.width*0.2).isActive = true
        
        searchText.heightAnchor.constraint(equalToConstant: contentView.frame.height).isActive = true
        dateText.heightAnchor.constraint(equalToConstant: contentView.frame.height).isActive = true
        
        return outerView
    }()
}
