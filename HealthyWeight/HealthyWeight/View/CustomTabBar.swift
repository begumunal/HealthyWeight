//
//  CustomTabBar.swift
//  HealthyWeight
//
//  Created by Begum Unal on 30.05.2023.
//

import Foundation
import UIKit
class CustomTabBar: UITabBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTabBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTabBar()
    }
    
    private func setupTabBar() {
        
        self.backgroundColor = AppColors.barGreen
        self.tintColor = AppColors.textColor
        
    }
}
