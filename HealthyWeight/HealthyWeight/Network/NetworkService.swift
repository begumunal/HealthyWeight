//
//  NetworkService.swift
//  HealthyWeight
//
//  Created by Begum Unal on 4.05.2023.
//

import Foundation
import UIKit

class NetworkService{
    private weak var calorie: CalorieProtocol?
    let networkManager = NetworkManager()
    //let addItemVC = AddItemViewController()
    func getCalorie(query : String){
        networkManager.fetchNutritionInfo(for: query) { result in
            switch result {
            case .success(let data):
                print(data)
                if let jsonData = data.data(using: .utf8) {
                    do {
                        let response = try JSONDecoder().decode(Response.self, from: jsonData)
                        if let item = response.items.first {
                            let calories = item.calories
                            print("Calories: \(calories)")
                            self.calorie?.calorieValue = calories
                            DispatchQueue.main.async {
                                //let addItemVC = AddItemViewController()
                                //addItemVC.calorie = calories
                                //addItemVC.imageCalorieLabel.text = String(calories)
                            }
                            
                            
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
