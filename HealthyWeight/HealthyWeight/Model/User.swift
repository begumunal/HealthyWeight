//
//  User.swift
//  HealthyWeight
//
//  Created by Begum Unal on 2.05.2023.
//

import Foundation

struct UserModel : Encodable{
    var age : Int
    var length : Int
    var currentWeight : Int
    var goalWeight : Int
    var isWomen : Bool
    var motionState : Int
    var dailyCalorie : Double
    init(age: Int, length: Int, currentWeight: Int, goalWeight: Int, isWomen: Bool, motionState: Int, dailyCalorie : Double) {
        self.age = age
        self.length = length
        self.currentWeight = currentWeight
        self.goalWeight = goalWeight
        self.isWomen = isWomen
        self.motionState = motionState
        self.dailyCalorie = dailyCalorie
    }
    
}
