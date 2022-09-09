//
//  LoginPresenter.swift
//  PostKzTest
//
//  Created by Amir on 09.09.2022.
//

import UIKit

protocol LoginPresenterProtocol {
    init(view: LoginViewProtocol)
    
    func setSegmentControlPlaceholder(with type: UserModelType)
    
    func checkAuthorization(login: String?, password: String?)
}

final class LoginPresenter: LoginPresenterProtocol {
    
    unowned private let view: LoginViewProtocol
    private var modelType: UserModelType = .phoneModel
    private let authorizationService = AuthorizationService()
    
    required init(view: LoginViewProtocol) {
        self.view = view
    }
    
    func setSegmentControlPlaceholder(with type: UserModelType) {
        let textFieldPlaceholder: String
        
        switch type {
        case .phoneModel:
            modelType = .phoneModel
            textFieldPlaceholder = "Номер мобильного телефона"
        case .loginModel:
            modelType = .loginModel
            textFieldPlaceholder = "Логин"
        }
        
        view.changeSegmentControlPlaceholder(placeholder: textFieldPlaceholder)
    }
    
    func checkAuthorization(login: String?, password: String?) {
        var isAuthorize = false
        
        guard let login = login,
              let password = password else {
            view.authorizeUser(isAuthorize)
            
            return
        }
        
        switch modelType {
        case .phoneModel:
            guard let number = Int(login) else {
                view.authorizeUser(isAuthorize)
                
                return
            }
            let model = PhoneUserModel(number: number, password: password)
            
            isAuthorize = authorizationService.checkUser(with: .authorizationByPhone(model))
        case .loginModel:
            let mail = login + "@post.kz"
            let model = LoginUserModel(mail: mail, password: password)
            
            isAuthorize = authorizationService.checkUser(with: .authorizationByLogin(model))
        }
        
        view.authorizeUser(isAuthorize)
    }
}
