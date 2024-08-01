//
//  RecipeQuriesListViewModel.swift
//  foodRecipe
//
//  Created by hwanghr on 2024/06/21.
//

import Foundation

struct RecipeQuriesListViewModelActions{
    
}

protocol RecipeQuriesListViewModelInput{
    
}

protocol RecipeQuriesListViewModelOutput{
    
}

typealias RecipeQuriesListViewModel = RecipeQuriesListViewModelInput&RecipeQuriesListViewModelOutput

final class DefaultRecipeQuriesListViewModel:RecipeQuriesListViewModel{

/// 유즈케이스를 도출할 때 무엇을 기준으로 도출해야 하는가?     
    /// vc에서 발생하는 이벤트에 대하여, 
    /// 1. 유저가 발생시키는 이벤트
    /// 2. 화면 실행시 자동으로 실행되는 로직도 유즈케이스에 포함되는가? presentation영역을 통하여 실행되는 모든 비즈니스 로직
    /// 3. 이미지패치로직은 왜 유즈케이스로 도출하지 않았을까? 비즈니스로직이 필요한 것이 아니라 단순 데이터 조회만 필요하기 때문에
    /// 4. 추천 이벤트를 발생시키기위한 날씨조회는 유즈케이스로 도출해야 하는가?  날씨추천 유즈케이스를 만드는 것이 옳은가?
    private let fetchQuriesUseCase:FetchRecentRecipeQuriesUseCase
    private let removeQuriesUseCase:RemoveRecentRecipeQuriesUseCase
    
}
