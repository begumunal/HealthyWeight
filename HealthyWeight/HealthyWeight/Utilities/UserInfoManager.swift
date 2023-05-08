//
//  UserInfoManager.swift
//  HealthyWeight
//
//  Created by Begum Unal on 7.05.2023.
//

import Foundation

//Singleton
class UserInfoManager {
    static let shared = UserInfoManager()
    var userID: String?
    var userDailyCalorie : Double?
    
    private init() {}
}
