//
//  LogoNavigationItemBehavior.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/25.
//

import UIKit

enum BarType{
    case logo_searchAreaButton_blank
    case back_searchBar_serchButton
    case back_searchTitle_searchBtn
}

struct ItemsNavigationBarBehavior: ViewControllerLifecycleBehavior {
    
    private let type:BarType
    
    init(type:BarType){
        self.type = type
    }
    
    func viewDidLoad(viewController: UIViewController) {
        
        //back버튼을 커스텀하는 경우 부모view에서 커스텀해야 적용되므로 메인 화면에서 커스텀해야 함
        customBackButton(viewController: viewController)
        
        switch type{
        case BarType.logo_searchAreaButton_blank:
            addLogoItem(viewController: viewController)
            addsearchAreaButton(viewController: viewController)
            
        case BarType.back_searchBar_serchButton:
            addSearchBar(viewController: viewController)
            addSearchButton(viewController: viewController)
            
        case .back_searchTitle_searchBtn:
            print()
        }
        
    }
    
    func customBackButton(viewController:UIViewController){

        guard let navigationBar = viewController.navigationController?.navigationBar else {
            return
        }

        let image = UIImage(systemName: "arrowshape.backward.fill")
        image?.withTintColor(.black)
        
        //navigationItem과 navigationBar의 차이점은? navigationBar는 모든vc의 공통객체이고, navigationItem은 각vc의 객체이다.
        //navigationbar의 기본이미지를 사라지게하고, navigationItem을 통해 backButton을 커스텀하는 코드
        navigationBar.backIndicatorImage = UIImage()
        navigationBar.backIndicatorTransitionMaskImage = UIImage()
        
        let backButton = UIBarButtonItem()
        backButton.image = image
        backButton.tintColor = .black
        viewController.navigationItem.backBarButtonItem = backButton
        
        
    }
    
    func addLogoItem(viewController:UIViewController){
        
        guard let navigationBar = viewController.navigationController?.navigationBar else {
            return
        }
        
        let image = UIImage(named: "logo")
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = UIView.ContentMode.scaleToFill

        imageView.widthAnchor.constraint(equalToConstant: navigationBar.frame.width * 0.3).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: navigationBar.frame.height * 0.9).isActive = true
        
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        
    }
    
    func addsearchAreaButton(viewController:UIViewController){ 
        
        guard let navigationBar = viewController.navigationController?.navigationBar else {
            return
        }
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: navigationBar.frame.width * 0.7, height: navigationBar.frame.height * 0.8))
        label.backgroundColor = UIColor.white
        label.text = "메뉴를 검색해보세요"
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        
        ///masksToBounds의 디폴트 값은 false이고 true로 바꿔야 radius가 적용된다.
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        
        viewController.navigationItem.titleView = label
    }
    
    func addSearchBar(viewController:UIViewController){
        
        let searchBar = UISearchBar()
        searchBar.placeholder = "레시피를 검색해보세요"
        ///디폴트로 생성되는 왼쪽 돋보기 이미지 제거
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        viewController.navigationItem.titleView = searchBar
    }

    func addSearchButton(viewController:UIViewController){

        guard let navigationBar = viewController.navigationController?.navigationBar else {
            return
        }
        
        let height = navigationBar.frame.height
        let width = navigationBar.frame.width

        let image = UIImage(systemName: "magnifyingglass")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width * 0.3, height: height * 0.3))
        imageView.image = image
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill

        let widthConstraint = imageView.widthAnchor.constraint(equalToConstant: height*0.7)
        let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: height * 0.7)
        heightConstraint.isActive = true
        widthConstraint.isActive = true

        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: imageView)

    }

//    
//    func addCategoryLabelToNavbar(categoryName:String){
//        let width = navigationController?.navigationBar.frame.width ?? 0
//        let height = navigationController?.navigationBar.frame.height ?? 0
//        
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width * 0.7, height: height * 0.8))
//        label.text = categoryName
//        label.textColor = .black
//        label.textAlignment = .center
//        label.font = UIFont.systemFont(ofSize: 15)
//        
//        navigationItem.titleView = label
//        
//    }
//
//    
//    @objc func searchEvent(sender: UITapGestureRecognizer){
////        guard let vc = UIStoryboard(name: "SearchListView", bundle: nil).instantiateViewController(withIdentifier: "searchlistview") as? SearchListViewController else { return }
////        
////        ///레시피 검색 리스트화면에서 검색을 여러번 하는 경우 검색화면이 계속 중첩되지 않도록 하기 위한 코드
////        let vcCount = navigationController?.viewControllers.count
////        if vcCount! >= 2 && navigationController?.viewControllers[vcCount!-2] is SearchListViewController{
////            (navigationController?.viewControllers[vcCount!-2] as! SearchListViewController).searchKeyword = "Hamburgur"
////            navigationController?.popViewController(animated: false)
////        }
////        else {
////            navigationController?.pushViewController(vc, animated: false)   
////        }
////        print("searchEvent")
//    }

}
