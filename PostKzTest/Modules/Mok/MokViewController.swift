//
//  MokViewController.swift
//  PostKzTest
//
//  Created by Amir on 11.09.2022.
//

import UIKit

final class MokViewController: UIViewController {
    
    private var viewModel: ViewModel
    
    @IBOutlet private weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    init(model: ViewModel) {
        viewModel = model
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        overrideUserInterfaceStyle = .light
        
        textLabel.text = viewModel.text
        textLabel.textColor = viewModel.textColor
        self.view.backgroundColor = viewModel.backgroundColor
    }
}
