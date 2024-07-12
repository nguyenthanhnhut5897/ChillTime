//
//  UserRepositoryCachesHandler.swift
//  ChillTime
//
//  Created by Nguyen Thanh Nhut on 2023/04/27.
//

import Foundation

final class UserRepositoryCachesHandler: UserRepositoryCaches {
    func saveRecentLoginQuery(query: LoginParams, completion: @escaping (Result<CUserDTO, Error>) -> Void) {
        return
    }
    
    func saveRecentUserQuery(query: UserProfileParams, completion: @escaping (Result<CUserDTO, Error>) -> Void) {
        return
    }
}
