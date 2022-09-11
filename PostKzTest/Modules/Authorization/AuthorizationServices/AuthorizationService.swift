//
//  AuthorizationService.swift
//  PostKzTest
//
//  Created by Amir on 09.09.2022.
//

//import Foundation
//
protocol AuthorizationServiceProtocol {
    func checkUser(with model: AuthorizationType) -> Bool
}

enum AuthorizationType {
    case authorizationByPhone(PhoneUserModel)
    case authorizationByLogin(LoginUserModel)
}

class AuthorizationService: AuthorizationServiceProtocol {

    let phoneModel = PhoneUserModel(number: 111, password: "111")
    let loginModel = LoginUserModel(mail: "111@post.kz", password: "111")
    
    func checkUser(with model: AuthorizationType) -> Bool {
        switch model {
        case .authorizationByPhone(let model):
            guard model == phoneModel else { return false }
            
            return true
        case .authorizationByLogin(let model):
            guard model == loginModel else { return false }
            
            return true
        }
    }
}
