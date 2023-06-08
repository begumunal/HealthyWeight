//
//  CustomTextField.swift
//  HealthyWeight
//
//  Created by Begum Unal on 2.05.2023.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
   
    let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.width * 0.05), height: 20))
        
    init(keyboardType: UIKeyboardType, text: String?) {
        super.init(frame: .zero)
        
        self.configure(keyboardType: keyboardType, text: text)

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure(keyboardType : UIKeyboardType, text : String?) {
        isUserInteractionEnabled = true
        attributedPlaceholder = NSAttributedString(string: text ?? "", attributes: [NSAttributedString.Key.foregroundColor: AppColors.textColor!])
        self.keyboardType = keyboardType
        font = UIFont.systemFont(ofSize: 12, weight: .medium)
        leftView = self.leftPadding
        leftViewMode = .always
        layer.borderWidth = 0.6
        layer.borderColor = AppColors.textColor?.cgColor
        backgroundColor = AppColors.mainColor
        textColor = AppColors.textColor
        textAlignment = .left
        layer.cornerRadius = 23
        autocorrectionType = .no
        autocapitalizationType = .none
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width * 0.88)),
            heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height * 0.05))
            
        ])
        
        
    }
}
