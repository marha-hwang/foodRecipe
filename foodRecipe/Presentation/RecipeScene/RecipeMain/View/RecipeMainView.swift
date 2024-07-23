
import Foundation
import UIKit

//VC에서 접근이 필요한 모든 View에 대하여 전역변수로 선언하기
class RecipeMainView:UIView{
    
    private lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        var mainView:UIView = {
            let mainView = UIView()
            mainView.translatesAutoresizingMaskIntoConstraints = false
            
            lazy var categoryView:HorizontalFolderView = {
                let categoryView = HorizontalFolderView()
                categoryView.translatesAutoresizingMaskIntoConstraints = false
                categoryView.axis = .vertical
                categoryView.alignment = .center
                categoryView.distribution = .fillProportionally
                categoryView.spacing = 10
                
                return categoryView
            }()
            
            //반복되는 UI를 생성하기 위해 함수를 사용하면 내부요소에 접근이 불가하기 때문에 class를 이용하여 모듈화
            lazy var weatherRecommand:UIStackView = {
                let weatherRecommand = makeRecommandView(title: delegate.weatherRecommandTitle)
                
                return weatherRecommand
            }()
            
            lazy var timeRecommand:UIStackView = {
                let temperatureRecommand = makeRecommandView(title: delegate.timeRecommandTitle)
                
                return temperatureRecommand
            }()
            
            return mainView
        }()
        
        return scrollView
        
    }()
    
    lazy var mainView:UIView = {
        let mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    
    lazy var categoryView:HorizontalFolderView = {
        let categoryView = HorizontalFolderView()
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        categoryView.axis = .vertical
        categoryView.alignment = .center
        categoryView.distribution = .fillProportionally
        categoryView.spacing = 10
        
        return categoryView
    }()
    
    lazy var weatherRecommand:UIStackView = {
        let weatherRecommand = makeRecommandView(title: delegate.weatherRecommandTitle)
        
        return weatherRecommand
    }()
    
    lazy var timeRecommand:UIStackView = {
        let temperatureRecommand = makeRecommandView(title: delegate.timeRecommandTitle)
        
        return temperatureRecommand
    }()
    
    public func setLayout(){
        self.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
        scrollView.addSubview(mainView)
        mainView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor).isActive = true
        ///ScrollView의 내부View의 크기를 정해줌으로써 ScrollView의 크기가 정해진다.
        mainView.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        
        mainView.backgroundColor = .yellow
        
        mainView.addSubview(categoryView)
        categoryView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 30).isActive = true
        categoryView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10).isActive = true
        categoryView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
    
        ///Stroryboard에는 top, leading, trailling, width의 제약조건만 설정하였고, 아래 함수 호출을  통해 subView의 크기가 정해짐으로써 오토레이아웃이 완성됨
        addCategoryView()

        mainView.addSubview(weatherRecommand)
        weatherRecommand.topAnchor.constraint(equalTo: categoryView.bottomAnchor, constant: 30).isActive = true
        weatherRecommand.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10).isActive = true
        weatherRecommand.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
        
        mainView.addSubview(timeRecommand)
        timeRecommand.topAnchor.constraint(equalTo: weatherRecommand.bottomAnchor, constant: 30).isActive = true
        timeRecommand.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10).isActive = true
        timeRecommand.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
        timeRecommand.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10).isActive = true
    }
    
    private func addCategoryView(){
        categoryView.backgroundColor = .white
        categoryView.initForderView(items: delegate.categoryItems, defaultRow: 2, col: 4){ [weak self] gesture in
            self?.delegate.categoryTouchEvent(category:gesture.name ?? "")
        }
    }
    
   
    
    @objc func moveToCategoryView(gesture:UIGestureRecognizer){
        delegate.categoryTouchEvent(category: gesture.name ?? "")
    }
}

class RecommandView:UIStackView{
    var title:UITextView
    var moveImage:UIImageView
    
    lazy var recommandView:UIStackView = {
        let recommandView = UIStackView()
        recommandView.translatesAutoresizingMaskIntoConstraints = false
        recommandView.axis = .vertical
        recommandView.alignment = .fill
        recommandView.distribution = .fillProportionally
        recommandView.backgroundColor = .black
        
        lazy var headerView:UIStackView = {
            let headerView = UIStackView()
            headerView.translatesAutoresizingMaskIntoConstraints = false
            headerView.axis = .horizontal
            headerView.alignment = .center
            headerView.distribution = .fillProportionally
            
            title = {
                let textView = UITextView()
                textView.translatesAutoresizingMaskIntoConstraints = false
                textView.textAlignment = .center
                textView.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
                title.text = ""
                
                return textView
            }()
            
            lazy var imageView:UIImageView = {
                let imageView = UIImageView()
                imageView.translatesAutoresizingMaskIntoConstraints = false
                let image = UIImage(systemName: "arrowshape.forward.fill")
                imageView.image = image
                imageView.contentMode = .scaleToFill
                imageView.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
                
                let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(moveToCategoryView(gesture:)))
                gestureRecognizer.name = textView.text
                imageView.isUserInteractionEnabled = true
                imageView.addGestureRecognizer(gestureRecognizer)
                
                return imageView
            }()
            
            headerView.addArrangedSubview(textView)
            headerView.addArrangedSubview(imageView)
            
            textView.widthAnchor.constraint(equalToConstant: 100).isActive = true
            textView.heightAnchor.constraint(equalToConstant: 30).isActive = true
             
            imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
            
            return headerView
        }()
        
        lazy var recipeCollection:UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 300, height: 300)
            
            let recipeCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            recipeCollection.translatesAutoresizingMaskIntoConstraints = false
            recipeCollection.backgroundColor = .orange
            recipeCollection.register(RecipeMainItemCell.self, forCellWithReuseIdentifier: RecipeMainItemCell.identifier)
            recipeCollection.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            recipeCollection.translatesAutoresizingMaskIntoConstraints = false
            
//                recipeCollection.dataSource = self
//                recipeCollection.delegate = self
            
            return recipeCollection
        }()
        
        recommandView.addArrangedSubview(headerView)
        recommandView.addArrangedSubview(recipeCollection)
        
        recipeCollection.heightAnchor.constraint(equalToConstant: 300).isActive = true
        //recipeCollection.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*0.4).isActive = true
        
        return recommandView
    }()
    
    return recommandView
}
