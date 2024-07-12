//
//  UserRepositoryHandler.swift
//  ChillTime
//
//  Created by Nguyen Thanh Nhut on 2023/04/07.
//

import Foundation


final class UserRepositoryHandler {
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension UserRepositoryHandler: UserRepository {
    func login(query: LoginParams,
               cached: @escaping (CUser?) -> Void,
               completion: @escaping (Result<CUser?, Error>) -> Void) -> Cancellable?
    {
        
        #warning("use the dataTransferService to call api like a dataTransferService.request(params)")
        getAnAnswer { result in
            switch result {
            case .success(let user):
                completion(.success(user?.transferToUser()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        let task = RepositoryTask()
//
//        cache.getResponse(for: requestDTO) { result in
//
//            if case let .success(responseDTO?) = result {
//                cached(responseDTO.toDomain())
//            }
//            guard !task.isCancelled else { return }
//
//            let endpoint = APIEndpoints.getMovies(with: requestDTO)
//            task.networkTask = self.dataTransferService.request(with: endpoint) { result in
//                switch result {
//                case .success(let responseDTO):
//                    self.cache.save(response: responseDTO, for: requestDTO)
//                    completion(.success(responseDTO.toDomain()))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//        }
        return task
    }
    
    func updateProfile(query: UserProfileParams,
                       cached: @escaping (CUser?) -> Void,
                       completion: @escaping (Result<CUser?, Error>) -> Void) -> Cancellable?
    {
        return RepositoryTask()
    }
}
