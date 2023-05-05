//
//  RepositoryTask.swift
//  ChillTime
//
//  Created by Nguyen Thanh Nhut on 2023/04/07.
//

import Foundation

protocol NetworkCancellable {
    func cancel()
}

class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
