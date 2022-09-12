//
//  HomePresenter.swift
//  PostKzTest
//
//  Created by Amir on 12.09.2022.
//

import Foundation
import UIKit

protocol HomePresenterProtocol {
    
    var view: HomeViewProtocol! { get set }
    
    func setTextToLabel(text: String)
}

final class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol!
    
    init(view: HomeViewProtocol) {
        self.view = view
    }
    
    func setTextToLabel(text: String) {
        let backgroundColor = UIColor.random
        let textColor = UIColor.random
        
        let viewModel = ViewModel(text: text,
                                  textColor: textColor,
                                  backgroundColor: backgroundColor)
        
        
        view.showController(viewModel: viewModel)
    }
}
