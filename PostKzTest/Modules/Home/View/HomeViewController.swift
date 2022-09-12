//
//  HomeViewController.swift
//  PostKzTest
//
//  Created by Amir on 10.09.2022.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func showController(viewModel: HomeViewModel)
}

final class HomeViewController: UIViewController {
    
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var showStatusButton: UIButton!
    @IBOutlet private weak var scrollView: UIScrollView!

    private var presenter: HomePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    private func configureView() {
        presenter = HomePresenter(view: self)
        
        overrideUserInterfaceStyle = .light
        
        showStatusButton.layer.borderColor = UIColor.tintColor.cgColor
        
        searchTextField.setSearchButton()
        
        searchTextField.delegate = self
        
        self.dismissKeyboard()
    }
}

//MARK: HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    func showController(viewModel: HomeViewModel) {
        let mokViewController = MockViewController(model: viewModel)
        
        show(mokViewController, sender: self)
    }
}
//MARK: IBAction methods
private extension HomeViewController {
    @IBAction func showButtonDidTap(_ sender: UIButton) {
        guard let text = sender.titleLabel?.text else { return }
        
        presenter.setTextToLabel(text: text)
    }
}

//MARK: UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return false
    }
}
