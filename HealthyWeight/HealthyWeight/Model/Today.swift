//
//  TodayModel.swift
//  HealthyWeight
//
//  Created by Begum Unal on 30.05.2023.
//

import Foundation
import UIKit

struct TodayModel{
    var image : String 
    var foodName: String
    var foodCalorie: Double
    var date: String
    init(image: String, foodName: String, foodCalorie: Double, date: String) {
        self.image = image
        self.foodName = foodName
        self.foodCalorie = foodCalorie
        self.date = date
    }
}
