//
//  CUserDTO.swift
//  ChillTime
//
//  Created by Thanh Nhut on 12/7/24.
//

import Foundation

struct CUserDTO: Codable, Equatable, Identifiable {
    typealias Identifier = String
    
    let id: Identifier
    let name: String?
    
    func transferToUser() -> CUser {
        return CUser(id: id, name: name)
    }
}
