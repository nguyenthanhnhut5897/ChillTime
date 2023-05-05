//
//  GetAnswerRequest.swift
//  YourEyes
//
//  Created by Nguyen Thanh Nhut on 2022/07/10.
//
import UIKit

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


func getAnAnswer(completion: @escaping (Result<CUser?, Error>) -> Void) {
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else {
            completion(.failure(NSError(domain: "", code: 234)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            if let error = error {
                print("Error with fetching films: \(error)")
                completion(.failure(NSError(domain: "", code: 234)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                completion(.failure(NSError(domain: "", code: 234)))
                return
            }
            
            print(data ?? "", "=============", response ?? "")
            
            if let data = data,
               let user = try? JSONDecoder().decode(CUser.self, from: data) {
                print(user)
                completion(.success(user))
            }
        })
        
        task.resume()
    }
