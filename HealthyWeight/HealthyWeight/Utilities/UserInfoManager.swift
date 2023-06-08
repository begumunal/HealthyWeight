//
//  UserInfoManager.swift
//  HealthyWeight
//
//  Created by Begum Unal on 7.05.2023.
//

import Foundation
import UIKit

//Singleton
class UserInfoManager {
    static let shared = UserInfoManager()
    var userID: String?
    var userDailyCalorie : Double?
    var foodName: String?
    var foodCalorie: Double?
    var foodImage: UIImage?
    
    private init() {}
}
