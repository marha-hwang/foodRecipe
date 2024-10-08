
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
        categoryView.distribution = .equalCentering
        
        return categoryView
    }()
    
    lazy var firstRecommandView = RecommandView()
    lazy var secondRecommandView = RecommandView()
    
    
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
            
            mainView.addSubview(firstRecommandView)
            firstRecommandView.topAnchor.constraint(equalTo: categoryView.bottomAnchor, constant: 30).isActive = true
            firstRecommandView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10).isActive = true
            firstRecommandView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
            
            mainView.addSubview(secondRecommandView)
            secondRecommandView.topAnchor.constraint(equalTo: firstRecommandView.bottomAnchor, constant: 30).isActive = true
            secondRecommandView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10).isActive = true
            secondRecommandView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
            secondRecommandView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10).isActive = true
            
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

    lazy var titleView:UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.backgroundColor = .white
        textView.font = UIFont.systemFont(ofSize: 16)
        
        return textView
        
    }()
    
    lazy var recipeController:RecipeMainCollectionViewController = RecipeMainCollectionViewController()
    
    private lazy var headerView:UIStackView = {
        let headerView = UIStackView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.axis = .horizontal
        headerView.alignment = .center
        headerView.distribution = .fillProportionally
        
        headerView.addArrangedSubview(titleView)
        
        titleView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 30).isActive = true

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
    
        addArrangedSubview(headerView)
        addArrangedSubview(recipeContainer)
        recipeContainer.heightAnchor.constraint(equalToConstant: 320.adjustH).isActive = true

    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
