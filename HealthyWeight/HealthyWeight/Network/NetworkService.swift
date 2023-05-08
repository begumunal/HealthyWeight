//
//  NetworkService.swift
//  HealthyWeight
//
//  Created by Begum Unal on 4.05.2023.
//

import Foundation
import UIKit

class NetworkService{
    let networkManager = NetworkManager()
    
    func getCalorie(query : String){
        networkManager.fetchNutritionInfo(for: query) { result in
            switch result {
            case .success(let data):
                print(data)

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
