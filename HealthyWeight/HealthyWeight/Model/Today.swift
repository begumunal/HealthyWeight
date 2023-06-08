//
//  TodayModel.swift
//  HealthyWeight
//
//  Created by Begum Unal on 30.05.2023.
//

import Foundation
import UIKit

struct FoodModel{
    var image : String 
    var foodName: String
    var foodCalorie: Double
    
    init(image: String, foodName: String, foodCalorie: Double) {
        self.image = image
        self.foodName = foodName
        self.foodCalorie = foodCalorie
        
    }
}
