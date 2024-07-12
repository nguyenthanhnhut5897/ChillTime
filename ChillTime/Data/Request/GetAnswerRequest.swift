//
//  GetAnswerRequest.swift
//  YourEyes
//
//  Created by Nguyen Thanh Nhut on 2022/07/10.
//
import UIKit
import iOSAPIService

public extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}

public enum ResponseError: Error {
    case unacceptableStatusCode(Int)
    case unexpectedResponse(Any)
}

protocol DataTransferService {
    typealias CompletionHandler<T> = (Result<T, Error>) -> Void
}

final class DefaultDataTransferService: DataTransferService {
}

struct CAnswerRequest: Requestable {
    
    typealias Response = CUserDTO
    
    var baseURL: URL? {
        return URL(string: "https://dog.ceo/api/breeds/image/random")
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "m_addGuestInformation"
    }
    
    var headerField: [String : String] {
        return ["Content-Type" : "application/json"]
    }
}
