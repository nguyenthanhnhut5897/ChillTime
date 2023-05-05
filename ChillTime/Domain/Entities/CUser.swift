//
//  CUser.swift
//  ChillTime
//
//  Created by Nguyen Thanh Nhut on 2023/04/04.
//

import Foundation

struct CUser: Codable, Equatable, Identifiable {
    typealias Identifier = String
    
    let id: Identifier
    let name: String?
}
