//
//  NetworkManager.swift
//  HealthyWeight
//
//  Created by Begum Unal on 4.05.2023.
//

import Foundation
import UIKit

class NetworkManager {
    let apiKey = "1VBbOvyb4Fz7jl/PW/a89g==1sfW2allZo76uchy"
    
    func fetchNutritionInfo(for query: String, completion: @escaping (Result<String, Error>) -> Void) {
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.calorieninjas.com/v1/nutrition?query=" + query!)!
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data was not received"])
                completion(.failure(error))
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                    let items = json["items"] as? [[String: Any]] // örneğin items array'i içinde bir veya daha fazla öğe varsa
                    let firstItem = items?.first // ilk öğeyi alın
                    let calories = firstItem!["calories"] as? Double  // "calories" değerini çıkartın
                    print(calories!)
                   
                    
                    //self.sendData(data: calories!)
                    
                }
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
            
            let result = String(data: data, encoding: .utf8)!
            completion(.success(result))
        }
        task.resume()
    }
    
}
