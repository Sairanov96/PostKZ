//
//  MokViewController.swift
//  PostKzTest
//
//  Created by Amir on 11.09.2022.
//

import UIKit

final class MokViewController: UIViewController {
    
    private var textLabelText: String
    
    @IBOutlet private weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    init(text: String) {
        textLabelText = text
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        overrideUserInterfaceStyle = .light
        textLabel.text = textLabelText
    }
}
