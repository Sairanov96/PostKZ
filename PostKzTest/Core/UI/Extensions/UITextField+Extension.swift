//
//  UITextField+Extension.swift
//  PostKzTest
//
//  Created by Amir on 09.09.2022.
//

import UIKit

extension UITextField {
    func enablePasswordToggle() {
        let togglePasswordButton = UIButton(type: .custom)
        togglePasswordButton.tintColor = .gray
        togglePasswordButton.setImage(UIImage(systemName: "eye.circle.fill"), for: .normal)
        togglePasswordButton.setImage(UIImage(systemName: "eye.slash.circle.fill"), for: .selected)
        togglePasswordButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
        togglePasswordButton.addTarget(self, action: #selector(togglePasswordView(_:)), for: .touchUpInside)
        rightView = togglePasswordButton
        rightViewMode = .always
    }
    
    @objc func togglePasswordView(_ sender: UIButton) {
        isSecureTextEntry.toggle()
        sender.isSelected.toggle()
    }
    
    func enableMailLabel() {
        let mailLabel = PaddingLabel()
        mailLabel.font = .systemFont(ofSize: 14)
        mailLabel.paddingRight = 8.0
        mailLabel.text = "@post.kz"
        rightView = mailLabel
        rightViewMode = .always
    }
}
