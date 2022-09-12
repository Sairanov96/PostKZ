//
//  LoginViewController.swift
//  PostKzTest
//
//  Created by Amir on 08.09.2022.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    func changeSegmentControlPlaceholder(placeholder: String)
    
    func authorizeUser(_ isAuthorize: Bool)
}

final class AuthorizationLoginViewController: UIViewController {
    
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var segmentControlOutlet: UISegmentedControl!
    
    private var presenter: LoginPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        overrideUserInterfaceStyle = .light
        
        passwordTextField.enablePasswordToggle()
        presenter = LoginPresenter(view: self)
        
        self.dismissKeyboard()
    }
    
    @IBAction func showLoginPasswordButtonDidTap(_ sender: UIButton) {
        displayLoginPassword()
    }
}

extension AuthorizationLoginViewController: LoginViewProtocol {
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

private extension AuthorizationLoginViewController {
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

private extension AuthorizationLoginViewController {
    func displayLoginPassword() {
        let dialogMessage = UIAlertController(title: "Reminder", message: "Login: '111', Password: '111'", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        
        dialogMessage.addAction(ok)
        
        self.present(dialogMessage, animated: true, completion: nil)
    }
}
