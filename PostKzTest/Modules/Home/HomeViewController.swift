//
//  HomeViewController.swift
//  PostKzTest
//
//  Created by Amir on 10.09.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var showStatusButton: UIButton!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    private func configureView() {
        overrideUserInterfaceStyle = .light
        
        showStatusButton.layer.borderColor = UIColor.tintColor.cgColor
        
        searchTextField.setSearchButton()
        
        searchTextField.delegate = self
        
        self.dismissKeyboard()
    }
    
    private func showMokViewController(_ sender: UIButton) {
        guard let text = sender.titleLabel?.text else { return }
        
        let mokViewController = MokViewController(text: text)
        
        show(mokViewController, sender: self)
    }
}

private extension HomeViewController {
    @IBAction func findStatusButtonDidTap(_ sender: UIButton) {
        showMokViewController(sender)
    }
    
    @IBAction func scanButtonDidTap(_ sender: UIButton) {
        showMokViewController(sender)
    }
    
    @IBAction func showAllServices(_ sender: UIButton) {
        showMokViewController(sender)
    }
    
    @IBAction func callCourierButtonDidTap(_ sender: UIButton) {
        showMokViewController(sender)
    }
    
    @IBAction func bookQueueButtonDidTap(_ sender: UIButton) {
        showMokViewController(sender)
    }
    
    @IBAction func sendCardButtonDidTap(_ sender: UIButton) {
        showMokViewController(sender)
    }
    
    @IBAction func findBranchDidTap(_ sender: UIButton) {
        showMokViewController(sender)
    }
    
    @IBAction func paymentButtonDidTap(_ sender: UIButton) {
        showMokViewController(sender)
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return false
    }
}
