
import Foundation
import UIKit

//VC에서 접근이 필요한 모든 View에 대하여 전역변수로 선언하기
//화면을 그리는 로직과 데이터, 이벤트를 세팅하는 로직을 완전히 분리하고 싶음
//데이터, 이벤트의 대상이 되는 모든ui는 vc에서 접근 가능해야 함
//모든ui를 변수로 선언하는 것은 코드가 너무 지저분해짐: 깔끔하다의 기준은? 코드가 트리구조로 작성돼야 함
//MARK: 중복되는 view에 대해서는 class로 정의하여 모듈화
//MARK: 중복되는 view를 생성할때 함수를 사용하면 내부view에 접근하기 어려우므로 class를 통하여 생성
class RecipeMainView:UIView{
    
    lazy var categoryView:HorizontalFolderView = {
        let categoryView = HorizontalFolderView()
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        categoryView.axis = .vertical
        categoryView.alignment = .center
        categoryView.distribution = .fillProportionally
        categoryView.spacing = 10
        
        categoryView.layer.borderWidth = 1
        categoryView.layer.masksToBounds = true
        categoryView.layer.cornerRadius = 10
        categoryView.layer.borderColor = UIColor.black.cgColor
        categoryView.layer.borderWidth = 1
        
        return categoryView
    }()
    
    lazy var weatherRecommandView = RecommandView()
    lazy var timeRecommandView = RecommandView()
    
    
    private lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        var mainView:UIView = {
            let mainView = UIView()
            mainView.translatesAutoresizingMaskIntoConstraints = false
            
            mainView.addSubview(categoryView)
            categoryView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 30).isActive = true
            categoryView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10).isActive = true
            categoryView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
            
            mainView.addSubview(weatherRecommandView)
            weatherRecommandView.topAnchor.constraint(equalTo: categoryView.bottomAnchor, constant: 30).isActive = true
            weatherRecommandView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10).isActive = true
            weatherRecommandView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
            
            mainView.addSubview(timeRecommandView)
            timeRecommandView.topAnchor.constraint(equalTo: weatherRecommandView.bottomAnchor, constant: 30).isActive = true
            timeRecommandView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10).isActive = true
            timeRecommandView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
            timeRecommandView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10).isActive = true
            
            return mainView
        }()
        
        scrollView.addSubview(mainView)
        mainView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor).isActive = true
        mainView.widthAnchor.constraint(equalToConstant: frame.width).isActive = true

        return scrollView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class RecommandView:UIStackView{

    lazy var titleView:UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.backgroundColor = .white
        
        return textView
        
    }()
    lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "arrowshape.forward.fill")
        imageView.image = image
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .white
        imageView.tintColor = .black
        
        return imageView
    }()
    
    lazy var recipeController:RecipeMainCollectionViewController = RecipeMainCollectionViewController()
    
    private lazy var headerView:UIStackView = {
        let headerView = UIStackView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.axis = .horizontal
        headerView.alignment = .center
        headerView.distribution = .fillProportionally
        
        headerView.addArrangedSubview(titleView)
        headerView.addArrangedSubview(imageView)
        
        titleView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 30).isActive = true

        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        return headerView
    }()
    
    private lazy var recipeContainer:UIView = {
        let recipeContainer = UIView()
        recipeContainer.translatesAutoresizingMaskIntoConstraints = false
        
        recipeContainer.addSubview(recipeController.collectionView)
        recipeController.collectionView.leadingAnchor.constraint(equalTo: recipeContainer.leadingAnchor).isActive = true
        recipeController.collectionView.trailingAnchor.constraint(equalTo: recipeContainer.trailingAnchor).isActive = true
        recipeController.collectionView.topAnchor.constraint(equalTo: recipeContainer.topAnchor).isActive = true
        recipeController.collectionView.bottomAnchor.constraint(equalTo: recipeContainer.bottomAnchor).isActive = true
        
        return recipeContainer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        alignment = .fill
        distribution = .fillProportionally
        backgroundColor = .white
        
        layer.borderWidth = 1
        layer.masksToBounds = true
        layer.cornerRadius = 10
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    
        addArrangedSubview(headerView)
        addArrangedSubview(recipeContainer)
        recipeContainer.heightAnchor.constraint(equalToConstant: 300).isActive = true

    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
