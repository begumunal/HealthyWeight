//
//  CustomIcon.swift
//  HealthyWeight
//
//  Created by Begum Unal on 2.05.2023.
//

import Foundation
import UIKit

class CustomIcon : UIImageView{
    
    init(image: UIImage?, width: Int, height: Int) {
        guard let image = image else {
            fatalError("Image not found!")
        }
        
        super.init(image: image)
        
        self.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
