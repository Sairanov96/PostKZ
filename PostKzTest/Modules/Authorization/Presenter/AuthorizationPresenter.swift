//
//  AuthorizationPresenter.swift
//  PostKzTest
//
//  Created by Amir on 09.09.2022.
//


protocol AuthorizationPresenterProtocol {
    var view: AuthorizationViewProtocol! { get set }
    
    func setSegmentControlPlaceholder(with type: UserModelType)
    func checkAuthorization(login: String?, password: String?)
}

final class AuthorizationPresenter: AuthorizationPresenterProtocol {
    
    weak var view: AuthorizationViewProtocol!
    
    private var modelType: UserModelType = .phoneModel
    private let authorizationService: AuthorizationServiceProtocol
    
    init(view: AuthorizationViewProtocol, service: AuthorizationServiceProtocol) {
        self.view = view
        self.authorizationService = service
    }
    
    convenience init(view: AuthorizationViewProtocol) {
        self.init(view: view, service: AuthorizationService())
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
