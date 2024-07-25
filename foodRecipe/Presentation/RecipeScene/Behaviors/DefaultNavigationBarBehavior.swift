//
//  DefaultNavigationBarBehavior.swift
//  foodRecipe
//
//  Created by h2o on 2024/07/25.
//

import UIKit

struct DefaultNavigationBarBehavior: ViewControllerLifecycleBehavior {

    func viewDidLoad(viewController: UIViewController) {

        ///탭바, 네비게이션 화면뒤로 다른 뷰가 겹쳐지는 경우 색깔이 바뀌어서 추가한 설정
        viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
}
