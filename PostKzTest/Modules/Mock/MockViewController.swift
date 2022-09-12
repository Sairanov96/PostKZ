//
//  MockViewController.swift
//  PostKzTest
//
//  Created by Amir on 11.09.2022.
//

import UIKit

final class MockViewController: UIViewController {
    
    private var viewModel: HomeViewModel
    
    @IBOutlet private weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    init(model: HomeViewModel) {
        viewModel = model
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


//MARK: Private methods
private extension MockViewController {
    func setupView() {
        overrideUserInterfaceStyle = .light
        
        textLabel.text = viewModel.text
        textLabel.textColor = viewModel.textColor
        self.view.backgroundColor = viewModel.backgroundColor
    }
}
