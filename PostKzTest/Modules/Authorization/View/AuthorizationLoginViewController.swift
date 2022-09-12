//
//  AuthorizationLoginViewController.swift
//  PostKzTest
//
//  Created by Amir on 08.09.2022.
//

import UIKit

protocol AuthorizationViewProtocol: AnyObject {
    func changeSegmentControlPlaceholder(placeholder: String)
    func authorizeUser(_ isAuthorize: Bool)
}

final class AuthorizationLoginViewController: UIViewController {
    
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var segmentControlOutlet: UISegmentedControl!
    
    private var presenter: AuthorizationPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        overrideUserInterfaceStyle = .light
        
        passwordTextField.enablePasswordToggle()
        presenter = AuthorizationPresenter(view: self)
        
        self.dismissKeyboard()
    }
    
}
//MARK: AuthorizationViewProtocol
extension AuthorizationLoginViewController: AuthorizationViewProtocol {
    func changeSegmentControlPlaceholder(placeholder: String) {
        loginTextField.placeholder = placeholder
    }
    
    func authorizeUser(_ isAuthorize: Bool) {
        if isAuthorize {
            let homeViewController = HomeViewController()
            homeViewController.modalPresentationStyle = .fullScreen
            present(homeViewController, animated: true)
        }
    }
}

//MARK: IBAction methods
private extension AuthorizationLoginViewController {
    @IBAction func showLoginPasswordButtonDidTap(_ sender: UIButton) {
        displayLoginPassword()
    }
    
    @IBAction func segmentControlDidTap(_ sender: UISegmentedControl) {
        dismissKeyboard()
        loginTextField.text = nil
        
        switch sender.selectedSegmentIndex {
        case 0:
            loginTextField.rightView = nil
            loginTextField.keyboardType = .numberPad
            presenter.setSegmentControlPlaceholder(with: .phoneModel)
        default:
            loginTextField.enableMailLabel()
            loginTextField.keyboardType = .default
            presenter.setSegmentControlPlaceholder(with: .loginModel)
        }
    }
    
    @IBAction func authorizationButtonDidTap() {
        presenter.checkAuthorization(login: loginTextField.text, password: passwordTextField.text)
    }
}

//MARK: Private methods
private extension AuthorizationLoginViewController {
    func displayLoginPassword() {
        let dialogMessage = UIAlertController(title: "Reminder", message: "Login: '111', Password: '111'", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        
        dialogMessage.addAction(ok)
        
        self.present(dialogMessage, animated: true, completion: nil)
    }
}
