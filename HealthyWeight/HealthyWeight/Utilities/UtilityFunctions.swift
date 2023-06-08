//
//  UtilityFunctions.swift
//  HealthyWeight
//
//  Created by Begum Unal on 7.06.2023.
//

import Foundation
import UIKit

class UtilityFunctions{
    static func getDate() -> String{
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDateString = dateFormatter.string(from: currentDate)
        return currentDateString
    }
    
    static func convertBase64EncodedToUIImage(_ imageString: String) -> UIImage{
        if let imageData = Data(base64Encoded: imageString) {
            if let image = UIImage(data: imageData) {
                return image
            }
        }
        return UIImage()
    }
    
    static func goToNextView(nextVC: UIViewController){
        
    }
}
