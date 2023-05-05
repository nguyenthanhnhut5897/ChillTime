//
//  UserRepositoryCaches.swift
//  ChillTime
//
//  Created by Nguyen Thanh Nhut on 2023/04/07.
//

import Foundation

protocol UserRepositoryCaches {
    func saveRecentLoginQuery(
        query: LoginParams,
        completion: @escaping (Result<CUser, Error>) -> Void
    )
    
    func saveRecentUserQuery(
        query: UserProfileParams,
        completion: @escaping (Result<CUser, Error>) -> Void
    )
}
