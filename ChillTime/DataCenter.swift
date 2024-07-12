//
//  DataCenter.swift
//  ChillTime
//
//  Created by Nguyen Thanh Nhut on 2023/04/07.
//

import UIKit

class DataCenter {
    static var shared = DataCenter()
    // Check app status is opened or launching
    var hasLoadedApp: Bool = false
    // Equal true when app has requested push noti authorization
    var hasRequestedNotiPermission: Bool = false
    // Save data of push noti when app open after quit
    var userDataNoti: [AnyHashable : Any]?
    
    // Save the last error code when show pop up (top alert view of pop up)
    var lastErrorCodePopup: Int = -1
    
    
    lazy var appConfiguration = ChillTimeAPIConfig(type: .development)
    
    // MARK: - Network
    lazy var apiDataTransferService: DataTransferService = {
//        let config = ApiDataNetworkConfig(
//            baseURL: URL(string: appConfiguration.apiBaseURL)!,
//            queryParameters: [
//                "api_key": appConfiguration.apiKey,
//                "language": NSLocale.preferredLanguages.first ?? "en"
//            ]
//        )
//
//        let apiDataNetwork = DefaultNetworkService(config: config)
//        return DefaultDataTransferService(with: apiDataNetwork)
        return DefaultDataTransferService()
    }()
    
    lazy var paymentDataTransferService: Int = {
        return 0
    }()
}
