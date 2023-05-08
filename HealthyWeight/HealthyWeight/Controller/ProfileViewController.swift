//
//  ProfileViewController.swift
//  HealthyWeight
//
//  Created by Begum Unal on 3.05.2023.
//

import UIKit
import FirebaseDatabase
import FirebaseCore
import FirebaseAuth

class ProfileViewController: UIViewController {
    private let toolBar = UIToolbar()
    private let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
    private let dailyCalorieLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.textColor = AppColors.textColor
        return label
    }()
    private let dailyCalorieTextLabel : UILabel = {
        let label = UILabel()
        label.text = Constants.dailyCalorieTextLabel
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = AppColors.textColor
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setup()
        self.fetchData()
    }
    
    func setup(){
        self.view.backgroundColor = AppColors.mainColor
        toolBar.barTintColor = AppColors.barGreen
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), editButton]
        
        self.toolBar.translatesAutoresizingMaskIntoConstraints = false
        self.dailyCalorieLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dailyCalorieTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.toolBar)
        self.view.addSubview(self.dailyCalorieLabel)
        self.view.addSubview(self.dailyCalorieTextLabel)
        
        NSLayoutConstraint.activate([
            self.toolBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            self.toolBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.toolBar.widthAnchor.constraint(equalToConstant: view.frame.width),
            self.toolBar.heightAnchor.constraint(equalToConstant: 80),
            
            self.dailyCalorieLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.dailyCalorieLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            self.dailyCalorieTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.dailyCalorieTextLabel.bottomAnchor.constraint(equalTo: self.dailyCalorieLabel.topAnchor, constant: -30)
        ])
    }
    func fetchData(){
        guard let id = UserInfoManager.shared.userID else{return}
        print(String(id))
        let ref = Database.database().reference().child("\(id)")
        ref.child("dailyCalorie").observeSingleEvent(of: .value, with: { (snapshot) in
            let dailyCalorie = snapshot.value as? Double ?? 0.0
            print("Daily Calorie: \(dailyCalorie)")
            self.dailyCalorieLabel.text = String(dailyCalorie)
        }) { (error) in
            print(error.localizedDescription)
        }
     
    }

    @objc func editButtonTapped(){
        
    }
}
