//
//  UISegmentControl+Extension.swift
//  PostKzTest
//
//  Created by Amir on 12.09.2022.
//

import UIKit

extension UISegmentedControl {
    func setFontSize(fontSize: CGFloat) {
        
        let normalTextAttributes: [NSObject : AnyObject] = [
            NSAttributedString.Key.foregroundColor as NSObject: UIColor.black,
            NSAttributedString.Key.font as NSObject : UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.medium)
        ]
        
        let boldTextAttributes: [NSObject : AnyObject] = [
            NSAttributedString.Key.foregroundColor as NSObject : UIColor.black,
            NSAttributedString.Key.font as NSObject : UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.medium),
        ]
        
        self.setTitleTextAttributes(normalTextAttributes as? [NSAttributedString.Key : Any], for: .normal)
        self.setTitleTextAttributes(normalTextAttributes as? [NSAttributedString.Key : Any], for: .highlighted)
        self.setTitleTextAttributes(boldTextAttributes as? [NSAttributedString.Key : Any], for: .selected)
    }
}
