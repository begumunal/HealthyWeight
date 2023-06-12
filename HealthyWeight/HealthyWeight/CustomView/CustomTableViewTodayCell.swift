//
//  CustomTableViewCell.swift
//  HealthyWeight
//
//  Created by Begum Unal on 4.05.2023.
//

import Foundation
import UIKit

class CustomTableViewTodayCell: UITableViewCell {
    
    let foodNameLabel = UILabel()
    let foodCalorieLabel = UILabel()
    let foodImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = AppColors.mainColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.layer.borderColor = AppColors.barGreen?.cgColor
        self.clipsToBounds = true
        foodImage.frame = CGRect(x: 30, y: 0, width: 40, height: 40)
        foodNameLabel.frame = CGRect(x: self.frame.width / 2 - 50, y: 0, width: 100, height: self.frame.height)
        foodCalorieLabel.frame = CGRect(x: self.frame.width - 60, y: 0, width: 100, height: self.frame.height)
        
        foodNameLabel.textColor = .black
        foodNameLabel.font = .boldSystemFont(ofSize: 13)
        foodNameLabel.font = UIFont.systemFont(ofSize: 14)
        foodCalorieLabel.textColor = .black
        foodCalorieLabel.font = UIFont.systemFont(ofSize: 14)
        foodImage.image = UIImage(named: "imageName")
        
        self.addSubview(foodNameLabel)
        self.addSubview(foodCalorieLabel)
        self.addSubview(foodImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
