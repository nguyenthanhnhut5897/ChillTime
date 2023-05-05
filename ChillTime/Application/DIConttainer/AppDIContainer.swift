//
//  AppDIContainer.swift
//  ChillTime
//
//  Created by Nguyen Thanh Nhut on 2023/04/15.
//

import Foundation

final class AppDIContainer {
    // MARK: - DIContainers of scenes
    func makeHomeIDContainer() -> HomeIDContainer {
        let dependencies = HomeIDContainer.Dependencies(
            apiDataTransferService: DataCenter.shared.apiDataTransferService
        )
        return HomeIDContainer(dependencies: dependencies)
    }
}
