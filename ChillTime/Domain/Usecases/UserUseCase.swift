//
//  UserUseCase.swift
//  ChillTime
//
//  Created by Nguyen Thanh Nhut on 2023/04/05.
//

import Foundation

protocol Cancellable {
    func cancel()
}

protocol CUseCase {}

protocol UserUseCase: CUseCase {
    func login(
        requestValue: LoginParams,
        cached: @escaping (CUser?) -> Void,
        completion: @escaping (Result<CUser?, Error>) -> Void
    ) -> Cancellable?
    
    func updateProfile(
        requestValue: UserProfileParams,
        cached: @escaping (CUser?) -> Void,
        completion: @escaping (Result<CUser?, Error>) -> Void
    ) -> Cancellable?
}

final class UserUseCaseHandler: UserUseCase {

    private let userRepository: UserRepository
    private let userRepositoryCaches: UserRepositoryCaches

    init(
        userRepository: UserRepository,
        userRepositoryCaches: UserRepositoryCaches
    ) {
        self.userRepository = userRepository
        self.userRepositoryCaches = userRepositoryCaches
    }
    
    func login(requestValue: LoginParams,
               cached: @escaping (CUser?) -> Void,
               completion: @escaping (Result<CUser?, Error>) -> Void) -> Cancellable?
    {
        return userRepository.login(query: requestValue, cached: cached) { result in
            if case .success = result {
                self.userRepositoryCaches.saveRecentLoginQuery(query: requestValue) { _ in }
            }
            
            completion(result)
        }
    }

    func updateProfile(requestValue: UserProfileParams,
                       cached: @escaping (CUser?) -> Void,
                       completion: @escaping (Result<CUser?, Error>) -> Void) -> Cancellable?
    {
        return userRepository.updateProfile(query: requestValue, cached: cached) { result in
            if case .success = result {
                self.userRepositoryCaches.saveRecentUserQuery(query: requestValue) { _ in }
            }
            
            completion(result)
        }
    }
}
