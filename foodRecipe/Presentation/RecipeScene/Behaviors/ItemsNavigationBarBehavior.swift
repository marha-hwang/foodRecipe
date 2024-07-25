//
//  LogoNavigationItemBehavior.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/25.
//

import UIKit

enum ItemType{
    case logo
    case searchAreaButton
    case searchImageButton
    case searchBar
    case searchTitle
    case back
    case blank
}

struct Items{
    let left:ItemType
    let center:ItemType
    let right:ItemType
}

struct ItemsNavigationBarBehavior: ViewControllerLifecycleBehavior {
    
    private let items:Items
    
    init(items:Items){
        self.items = items
    }
    
    func viewDidLoad(viewController: UIViewController) {
        
        
        
    }
    
    func addLogoToNavbar(){
        //navigation으로 화면전환된경우 vc에 navigationController이 존재한다.
        let navbar = navigationController?.navigationBar
        let height = navbar?.frame.height ?? 0
        let width = navbar?.frame.width ?? 0
        
        ///Asset에 추가한 이미지 파일을 불러와 ImageView크기에 맞게 레이아웃 설정
        let image = UIImage(named: "logo")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width * 0.3, height: height * 0.9))
        imageView.image = image
        imageView.contentMode = .scaleToFill

        ///네비게이션바에서 이미지의 위치를 조절하기 위해 레이아웃 설정 추가
        let widthConstraint = imageView.widthAnchor.constraint(equalToConstant: width * 0.3)
        let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: height * 0.9)
        heightConstraint.isActive = true
        widthConstraint.isActive = true
        
        ///tabbar로 현재 VC가 보이는 상황에서  tabbar의 navigationItem을 수정하여야 현재 vc에 적용된다??
        ///tabbar로 이동한 VC에는 navigationbar가 존재하지 않음, 이 상황에서 보이는 navigationbar는 tabbar의 navigationbar임
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        
    }
    
    func addSearchLabelToNavbar(){ 
        let width = navigationController?.navigationBar.frame.width ?? 0
        let height = navigationController?.navigationBar.frame.height ?? 0
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width * 0.7, height: height * 0.8))
        label.backgroundColor = .white
        label.text = "메뉴를 검색해보세요"
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        
        ///masksToBounds의 디폴트 값은 false이고 true로 바꿔야 radius가 적용된다.
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10

        ///라벨에 클릭이벤트 붙이는 코드
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(searchLabelEvent))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(gestureRecognizer)
        
        navigationItem.titleView = label
    }
    
    func addSearchBarToNavBar(){

        let searchBar = UISearchBar()
        searchBar.placeholder = "레시피를 검색해보세요"
        ///디폴트로 생성되는 왼쪽 돋보기 이미지 제거
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        navigationItem.titleView = searchBar
    }
    
    @objc func searchLabelEvent(sender: UITapGestureRecognizer){

//        guard let vc = UIStoryboard(name: "SearchView", bundle: nil).instantiateViewController(withIdentifier: "searchview") as? SearchViewController else { return }
//        navigationController?.pushViewController(vc, animated: false)
//        print("hellog")
    }
    
    func addCategoryLabelToNavbar(categoryName:String){
        let width = navigationController?.navigationBar.frame.width ?? 0
        let height = navigationController?.navigationBar.frame.height ?? 0
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width * 0.7, height: height * 0.8))
        label.text = categoryName
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        
        navigationItem.titleView = label
        
    }
    
    func addBackButtonToNavbar(){

        let navbar = navigationController?.navigationBar
        let height = navbar?.frame.height ?? 0
        let width = navbar?.frame.width ?? 0
        
        let image = UIImage(systemName: "arrowshape.backward.fill")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width * 0.3, height: height * 0.3))
        imageView.image = image
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill

        let widthConstraint = imageView.widthAnchor.constraint(equalToConstant: height*0.7)
        let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: height * 0.7)
        heightConstraint.isActive = true
        widthConstraint.isActive = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backEvent))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(gestureRecognizer)

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        
    }
    
    @objc func backEvent(sender: UITapGestureRecognizer){
        navigationController?.popViewController(animated: false)
    }
    
    
    func addSearchButtonToNavbar(){

        let navbar = navigationController?.navigationBar
        let height = navbar?.frame.height ?? 0
        let width = navbar?.frame.width ?? 0
        
        let image = UIImage(named: "search")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width * 0.3, height: height * 0.3))
        imageView.image = image
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill

        let widthConstraint = imageView.widthAnchor.constraint(equalToConstant: height*0.7)
        let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: height * 0.7)
        heightConstraint.isActive = true
        widthConstraint.isActive = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(searchEvent))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(gestureRecognizer)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: imageView)
        
    }
    
    @objc func searchEvent(sender: UITapGestureRecognizer){
//        guard let vc = UIStoryboard(name: "SearchListView", bundle: nil).instantiateViewController(withIdentifier: "searchlistview") as? SearchListViewController else { return }
//        
//        ///레시피 검색 리스트화면에서 검색을 여러번 하는 경우 검색화면이 계속 중첩되지 않도록 하기 위한 코드
//        let vcCount = navigationController?.viewControllers.count
//        if vcCount! >= 2 && navigationController?.viewControllers[vcCount!-2] is SearchListViewController{
//            (navigationController?.viewControllers[vcCount!-2] as! SearchListViewController).searchKeyword = "Hamburgur"
//            navigationController?.popViewController(animated: false)
//        }
//        else {
//            navigationController?.pushViewController(vc, animated: false)   
//        }
//        print("searchEvent")
    }
    
    func addSearchViewButtonToNavbar(){

        let navbar = navigationController?.navigationBar
        let height = navbar?.frame.height ?? 0
        let width = navbar?.frame.width ?? 0
        
        let image = UIImage(named: "search")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width * 0.3, height: height * 0.3))
        imageView.image = image
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill

        let widthConstraint = imageView.widthAnchor.constraint(equalToConstant: height*0.7)
        let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: height * 0.7)
        heightConstraint.isActive = true
        widthConstraint.isActive = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(searchViewEvent))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(gestureRecognizer)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: imageView)
        
    }
    
    @objc func searchViewEvent(sender: UITapGestureRecognizer){
//        guard let vc = UIStoryboard(name: "SearchView", bundle: nil).instantiateViewController(withIdentifier: "searchview") as? SearchViewController else { return }
//        navigationController?.pushViewController(vc, animated: false)
    }
}
