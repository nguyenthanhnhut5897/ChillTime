//
//  ValidateUseCase.swift
//  ChillTime
//
//  Created by Nguyen Thanh Nhut on 2023/04/04.
//

import Foundation

protocol ValidateUseCase {
    func validateLogin(params: Any) -> Observable<Bool>
}
