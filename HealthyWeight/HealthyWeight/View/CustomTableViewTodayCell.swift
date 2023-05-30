//
//  CustomTableViewCell.swift
//  HealthyWeight
//
//  Created by Begum Unal on 4.05.2023.
//

import Foundation
import UIKit

class CustomTableViewTodayCell: UITableViewCell {
    
    // Hücre içeriği için label'lar ve image tanımlanır.
    let foodNameLabel = UILabel()
    let foodCalorieLabel = UILabel()
    let foodImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = AppColors.mainColor
        // label'ların ve image'in boyutları ve konumları ayarlanır.
     
        foodImage.frame = CGRect(x: 30, y: 0, width: 40, height: 40)
        foodNameLabel.frame = CGRect(x: self.frame.width / 2 - 50, y: 0, width: 100, height: self.frame.height)
        foodCalorieLabel.frame = CGRect(x: self.frame.width - 60, y: 0, width: 100, height: self.frame.height)
        // label'ların ve image'in özellikleri ayarlanır.
        foodNameLabel.textColor = .black
        foodNameLabel.font = .boldSystemFont(ofSize: 13)
        foodNameLabel.font = UIFont.systemFont(ofSize: 14)
        foodCalorieLabel.textColor = .black
        foodCalorieLabel.font = UIFont.systemFont(ofSize: 14)
        foodImage.image = UIImage(named: "imageName")
        
        // label'lar ve image hücreye eklenir.
        self.addSubview(foodNameLabel)
        self.addSubview(foodCalorieLabel)
        self.addSubview(foodImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}