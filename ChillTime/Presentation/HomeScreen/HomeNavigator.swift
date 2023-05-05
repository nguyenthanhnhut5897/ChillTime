//
//  HomeNavigator.swift
//  ChillTime
//
//  Created by Nguyen Thanh Nhut on 2023/04/15.
//

import UIKit

#warning("là coordinator, nên private func navi trừ start, mọi thứ sẽ nhận lệnh từ action, các phương thức nên private, tránh tường hợp k đúng action nhưng lại mở sai page")
protocol HomeNavigatorDependencies {
    func makeHomeViewController(actions: HomeViewModelActions?) -> HomeViewController
    func makeUserDetailViewController(actions: HomeViewModelActions?) -> HomeViewController
}

final class HomeNavigator {
    
    private let navigationController: BaseNavigationController?
    private let dependencies: HomeNavigatorDependencies

    init(navigationController: BaseNavigationController,
         dependencies: HomeNavigatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = HomeViewModelActions(showUserDetails: showUserDetails)
        let vc = dependencies.makeHomeViewController(actions: actions)

        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func showUserDetails(user: CUser?) {
        let vc = dependencies.makeUserDetailViewController(actions: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}
