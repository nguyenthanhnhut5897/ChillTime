//
//  CUserDTO.swift
//  ChillTime
//
//  Created by Thanh Nhut on 12/7/24.
//

import UIKit

struct CUserDTO: Codable, Equatable, Identifiable {
    let id: String?
    let name: String?
    let message: [String]?
    let status: String?
    
    func transferToUser() -> CUser {
        return CUser(id: id, name: name)
    }
}
