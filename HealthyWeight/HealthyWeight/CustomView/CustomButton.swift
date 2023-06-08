//
//  CustomButton.swift
//  HealthyWeight
//
//  Created by Begum Unal on 2.05.2023.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    init(buttonTitle: String) {
        
        super.init(frame: .zero)
        self.setupButton(buttonTitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(_ buttonText : String) {
        setTitle(buttonText, for: .normal)
        setTitleColor(.black, for: .normal)
        contentHorizontalAlignment = .center
        titleLabel?.text = titleLabel?.text?.capitalized
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        layer.cornerRadius = 20
        backgroundColor = AppColors.barGreen
        isUserInteractionEnabled = true
        
    }
}
