//
//  HomeViewModel.swift
//  ChillTime
//
//  Created by Nguyen Thanh Nhut on 2023/04/14.
//

import Foundation

struct HomeViewModelActions {
    let showUserDetails: (CUser?) -> Void
}

protocol HomeViewModelInput {
    func fetchData()
}

protocol HomeViewModelOutput {
    var title: Observable<String?> { get }
}

final class HomeViewModel: BaseViewModel, HomeViewModelInput, HomeViewModelOutput {
    
    private let userUsecase: UserUseCase
    private let actions: HomeViewModelActions?
    private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }

    // MARK: - OUTPUT
    var title: Observable<String?> = Observable(nil)
    
    init(userUsecase: UserUseCase, actions: HomeViewModelActions?) {
        self.title.value = "Home"
        self.userUsecase = userUsecase
        self.actions = actions
    }
}

extension HomeViewModel {
    func fetchData() {
        let param = LoginParams(username: "n", password: "", installationId: "")
        
        imageLoadTask = userUsecase.login(requestValue: param,
                                          cached: { [weak self] user in
            self?.title.value = user?.name
        }, completion: { [weak self] result in
            
            switch result {
            case .success(let user):
                self?.title.value = user?.name
            case .failure: break
            }
            self?.imageLoadTask = nil
        })
    }
}
