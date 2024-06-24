//
//  RepositoryTask.swift
//  foodRecipe
//
//  Created by h2o on 2024/06/24.
//

import Foundation

class RepositoryTask: Cancellable {
    var networkTask:URLSessionDataTask?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
