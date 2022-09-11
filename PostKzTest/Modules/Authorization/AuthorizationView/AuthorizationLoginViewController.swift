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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
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
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
