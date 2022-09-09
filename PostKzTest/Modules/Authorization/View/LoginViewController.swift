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

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var segmentControlOutlet: UISegmentedControl!
    
    private var presenter: LoginPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        passwordTextField.enablePasswordToggle()
        presenter = LoginPresenter(view: self)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func segmentControlClick(_ sender: UISegmentedControl) {
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
    
    @IBAction func authorizationButtonClick(_ sender: UIButton) {
        presenter.checkAuthorization(login: loginTextField.text, password: passwordTextField.text)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension LoginViewController: LoginViewProtocol {
    func changeSegmentControlPlaceholder(placeholder: String) {
        loginTextField.placeholder = placeholder
    }
    
    func authorizeUser(_ isAuthorize: Bool) {
        print(isAuthorize)
    }
}
