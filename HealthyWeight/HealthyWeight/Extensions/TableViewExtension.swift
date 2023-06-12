//
//  TableViewExtension.swift
//  HealthyWeight
//
//  Created by Begum Unal on 7.06.2023.
//

import Foundation
import UIKit

extension TodayViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomTableViewTodayCell(style: .default, reuseIdentifier: "CustomTableViewTodayCell")
   
        cell.foodImage.image = UtilityFunctions.convertBase64EncodedToUIImage(self.foods[indexPath.row].image)
        cell.foodNameLabel.text = foods[indexPath.row].foodName
        cell.foodCalorieLabel.text = String(foods[indexPath.row].foodCalorie) + " cal"
        return cell
    }
}
