//
//  AuthorizationService.swift
//  PostKzTest
//
//  Created by Amir on 09.09.2022.
//

protocol AuthorizationServiceProtocol {
    func checkUser(with model: AuthorizationType) -> Bool
}

enum AuthorizationType {
    case authorizationByPhone(PhoneUserModel)
    case authorizationByLogin(LoginUserModel)
}

final class AuthorizationService {
    let phoneModel = PhoneUserModel(number: 111, password: "111")
    let loginModel = LoginUserModel(mail: "111@post.kz", password: "111")
}


//MARK: AuthorizationServiceProtocol
extension AuthorizationService: AuthorizationServiceProtocol {
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
