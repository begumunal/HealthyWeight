//
//  TodayViewController.swift
//  HealthyWeight
//
//  Created by Begum Unal on 3.05.2023.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class TodayViewController: UIViewController {
    var tableView = UITableView()
    private let toolBar = UIToolbar()
    private let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = Auth.auth().currentUser {
            UserInfoManager.shared.userID = user.uid
            print("User ID: \(UserInfoManager.shared.userID)")
        } else {
          print("No user is currently logged in.")
        }
        
        view.backgroundColor = AppColors.mainColor
        
        tableView.delegate = self
        tableView.dataSource = self
        self.setup()
    }
    

    func setup(){
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        addButton.tintColor = AppColors.textColor
        toolBar.barTintColor = AppColors.barGreen
        tableView.backgroundColor = AppColors.mainColor
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), addButton]
        
        self.toolBar.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(toolBar)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            self.toolBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            self.toolBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.toolBar.widthAnchor.constraint(equalToConstant: view.frame.width),
            self.toolBar.heightAnchor.constraint(equalToConstant: 80),
            
            self.tableView.topAnchor.constraint(equalTo: self.toolBar.bottomAnchor, constant: 0),
            self.tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.tableView.widthAnchor.constraint(equalToConstant: view.frame.width),
            self.tableView.heightAnchor.constraint(equalToConstant: view.frame.height),
            
            
        ])
        
    }
   

    @objc func addButtonTapped(){
        let nextVC = AddItemViewController()
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true)
        //self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
extension TodayViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomTableViewCell(style: .default, reuseIdentifier: "CustomTableViewCell")
        cell.foodNameLabel.text = "Sol Label"
        cell.foodCalorieLabel.text = "Orta Label"
        cell.foodImage.image = UIImage(named: "imageName")
        return cell
    }
    
    
}
