//
//  History.swift
//  HealthyWeight
//
//  Created by Begum Unal on 30.05.2023.
//

import Foundation

struct HistoryModel{
    var date: Date
    var totalCalorie: Double
    var isSuccess: Bool
    
    init(date: Date, totalCalorie: Double, isSuccess: Bool) {
        self.date = date
        self.totalCalorie = totalCalorie
        self.isSuccess = isSuccess
    }
}
