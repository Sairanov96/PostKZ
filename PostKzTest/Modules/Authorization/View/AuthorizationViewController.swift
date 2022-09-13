//
//  AuthorizationViewController.swift
//  PostKzTest
//
//  Created by Amir on 12.09.2022.
//

import UIKit
protocol AuthorizationViewProtocol: AnyObject {
    func changeSegmentControlPlaceholder(placeholder: String)
    func authorizeUser(_ isAuthorized: Bool)
}

class AuthorizationViewController: UIViewController {
    
    private var presenter: AuthorizationPresenterProtocol!
    
    private lazy var entryLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var segmentControl: UISegmentedControl = {
        let items = ["По номеру телефона", "Логин"]
        let segmentControl = UISegmentedControl(items: items)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentControlDidTap(_:)), for: .valueChanged)
        segmentControl.setFontSize(fontSize: 14)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        
        return segmentControl
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Номер мобильного телефона"
        textField.backgroundColor = .systemGray6
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 14, weight: .semibold)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.backgroundColor = .systemGray6
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 14, weight: .semibold)
        textField.enablePasswordToggle()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var forgotLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Забыли логин", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.addTarget(self, action: #selector(displayLoginPassword), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Забыли пароль", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.addTarget(self, action: #selector(displayLoginPassword), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    private lazy var credentialsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [forgotLoginButton, forgotPasswordButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .link
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(authorizationButtonDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var  questionLabel: UILabel = {
        let label = UILabel()
        label.text = "У вас еще не аккаунта post.kz?"
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = AuthorizationPresenter(view: self)
        self.hideKeyboardWhenTappedAround()
        
        setupView()
    }
    
}

//MARK: Setup View
private extension AuthorizationViewController {
    func setupView() {
        [entryLabel, segmentControl, loginTextField, passwordTextField, credentialsStackView, loginButton, questionLabel, registrationButton].forEach(view.addSubview(_:))
        
        view.backgroundColor = .white
        configureConstraints()
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            entryLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            entryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            segmentControl.topAnchor.constraint(equalTo: entryLabel.bottomAnchor, constant: 16),
            segmentControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            segmentControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            loginTextField.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 32),
            loginTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            loginTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            loginTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            credentialsStackView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 32),
            credentialsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            credentialsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            loginButton.topAnchor.constraint(equalTo: credentialsStackView.bottomAnchor, constant: 32),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            questionLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 32),
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            registrationButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 8),
            registrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

//MARK: Private methods
private extension AuthorizationViewController {
    @objc func authorizationButtonDidTap() {
        presenter.checkAuthorization(login: loginTextField.text, password: passwordTextField.text)
    }
    
    @objc func segmentControlDidTap(_ sender: UISegmentedControl) {
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
    
    @objc func displayLoginPassword() {
        let dialogMessage = UIAlertController(title: "Reminder", message: "Login: '111', Password: '111'", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)

        dialogMessage.addAction(ok)

        self.present(dialogMessage, animated: true, completion: nil)
    }
}

//MARK: LoginViewProtocol
extension AuthorizationViewController: AuthorizationViewProtocol {
    func changeSegmentControlPlaceholder(placeholder: String) {
        loginTextField.placeholder = placeholder
    }
    
    func authorizeUser(_ isAuthorized: Bool) {
        if isAuthorized {
            let homeViewController = HomeViewController()
            homeViewController.modalPresentationStyle = .fullScreen
            present(homeViewController, animated: true)
        }
    }
}
