//
//  UserRepository.swift
//  ChillTime
//
//  Created by Nguyen Thanh Nhut on 2023/04/07.
//

import Foundation

protocol CRepository {}

protocol UserRepository: CRepository {
    @discardableResult
    func updateProfile(
        query: UserProfileParams,
        cached: @escaping (CUser?) -> Void,
        completion: @escaping (Result<CUser?, Error>) -> Void
    ) -> Cancellable?
    
    @discardableResult
    func login(
        query: LoginParams,
        cached: @escaping (CUser?) -> Void,
        completion: @escaping (Result<CUser?, Error>) -> Void
    ) -> Cancellable?
}
