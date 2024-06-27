//
//  AppConfigurations.swift
//  foodRecipe
//
//  Created by haram on 6/27/24.
//

import Foundation

final class AppConfiguration {
    //실제 정보는 project단위 setting의 user-defined에 정의되어 있음
    lazy var apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        return apiKey
    }()
    lazy var apiBaseURL: String = {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }()
}
