//
//  ChillTimeAPIConfig.swift
//  ChillTime
//
//  Created by Nguyen Thanh Nhut on 2023/04/15.
//

import Foundation

enum ApiConfigType {
    case development
    case uat
    case production
    
    func getApiConfigTypeString() -> String {
        switch self {
        case .development:
            return "development"
        case .uat:
            return "uat"
        case .production:
            return "production"
        }
    }
    
    static func getAppEnvironment()-> ApiConfigType {
        if let environment = Bundle.main.object(forInfoDictionaryKey: "AppEnvironment") as? String {
            if environment == ApiConfigType.development.getApiConfigTypeString() {
                return .development
            } else if environment == ApiConfigType.uat.getApiConfigTypeString() {
                return .uat
            } else  if environment == ApiConfigType.production.getApiConfigTypeString() {
                return .production
            }
        }
        return .development
    }
}

protocol APIConfig {
    // Network
    var appId: String { get }
    var serverURL: String { get }
    var clientKey: String { get }
}

// MARK: - DevelopementConfig

fileprivate class DevelopementConfig: APIConfig {
    var appId: String {
        return ""
    }
    var serverURL: String {
        return "https://dog.ceo/api"
    }
    var clientKey: String {
        return ""
    }
}

// MARK: - UATConfig

fileprivate class UATConfig: APIConfig {
    var appId: String {
        return ""
    }
    var serverURL: String {
        return "https://dog.ceo/api"
    }
    var clientKey: String {
        return ""
    }
}

// MARK: - ProductionConfig

fileprivate class ProductionConfig: APIConfig {
    var appId: String {
        return ""
    }
    var serverURL: String {
        return "https://dog.ceo/api"
    }
    var clientKey: String {
        return ""
    }
}

struct ChillTimeAPIConfig {
    let type: ApiConfigType
    private(set) var config: APIConfig!
    
    init(type: ApiConfigType) {
        self.type = type
        
        switch type {
        case .development:
            config = DevelopementConfig()
        case .uat:
            config = UATConfig()
        case .production:
            config = ProductionConfig()
        }
    }
}

extension ChillTimeAPIConfig {
    var appId: String { return config.appId }
    var serverURL: String { return config.serverURL }
    var clientKey: String { return config.clientKey }

    // header
    #warning("move to API class")
    var httpAdditionalHeaders: [AnyHashable: Any] {
        var headers: [String: String] = ["os": "IOS"]
        
        if let appVersionString = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            headers["app-version"] = appVersionString
        }
        
        return headers
    }
}
