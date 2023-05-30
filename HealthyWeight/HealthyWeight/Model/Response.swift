//
//  Response.swift
//  HealthyWeight
//
//  Created by Begum Unal on 30.05.2023.
//

import Foundation
struct Item: Codable {
    let name: String
    let calories: Double
    let servingSize: Double
    // Diğer özellikler buraya eklenebilir

    private enum CodingKeys: String, CodingKey {
        case name, calories, servingSize = "serving_size_g"
        // Diğer özellikler buraya eklenebilir
    }
}

struct Response: Codable {
    let items: [Item]
}
