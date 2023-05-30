//
//  TodayViewController.swift
//  HealthyWeight
//
//  Created by Begum Unal on 3.05.2023.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase
class TodayViewController: UIViewController {
    var total = 0.0
    var todayModels: [TodayModel] = []
    var tableView = UITableView()
    var label = UILabel()
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
    

    override func viewWillAppear(_ animated: Bool) {
        self.loadData()
    }
    func setup(){
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        addButton.tintColor = AppColors.textColor
        toolBar.barTintColor = AppColors.barGreen
        tableView.backgroundColor = AppColors.mainColor
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), addButton]
        
        self.toolBar.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toolBar)
        view.addSubview(tableView)
        view.addSubview(label)
        NSLayoutConstraint.activate([
            self.toolBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            self.toolBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.toolBar.widthAnchor.constraint(equalToConstant: view.frame.width),
            self.toolBar.heightAnchor.constraint(equalToConstant: 80),
            
            self.label.topAnchor.constraint(equalTo: self.toolBar.bottomAnchor, constant: 0),
            self.label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.label.widthAnchor.constraint(equalToConstant: view.frame.width),
            self.label.heightAnchor.constraint(equalToConstant: 40),
            
            self.tableView.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 0),
            self.tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.tableView.widthAnchor.constraint(equalToConstant: view.frame.width),
            self.tableView.heightAnchor.constraint(equalToConstant: view.frame.height),
            
            
        ])
        
    }

    @objc func addButtonTapped(){
        let nextVC = AddItemViewController()
        nextVC.modalPresentationStyle = .fullScreen
        navigationItem.backButtonTitle = ""
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        present(nextVC, animated: true)
        
    }
    private func loadData(){
        guard let currentUser = Auth.auth().currentUser else { return }
        
        let userID = currentUser.uid
        let ref = Database.database().reference().child("today").child(userID)
        
        ref.observeSingleEvent(of: .value, with: { snapshot in
            if let value = snapshot.value as? [String: Any],
               let imageString = value["image"] as? String,
               let foodName = value["foodName"] as? String,
               let foodCalorie = value["foodCalorie"] as? Double,
               let date = value["date"] as? String{
                // Verileri kullanabilirsiniz
                let today = TodayModel(image: imageString, foodName: foodName, foodCalorie: foodCalorie, date: date)
                self.todayModels.append(today)
                self.tableView.reloadData()
                
            }
        })
    }
}
extension TodayViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todayModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomTableViewTodayCell(style: .default, reuseIdentifier: "CustomTableViewTodayCell")
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDateString = dateFormatter.string(from: currentDate)
        if self.todayModels[indexPath.row].date == currentDateString{
           
            for i in todayModels{
                total += i.foodCalorie
            }
            cell.foodNameLabel.text = self.todayModels[indexPath.row].foodName
            cell.foodCalorieLabel.text = String(self.todayModels[indexPath.row].foodCalorie) + " kalori"
          
            self.fetchData()
            if let imageData = Data(base64Encoded: self.todayModels[indexPath.row].image) {
                if let image = UIImage(data: imageData) {
                    cell.foodImage.image = image
                    
                }
            }
        }
      
        self.todayModels = []
        
        return cell
    }
    func fetchData(){
        guard let id = UserInfoManager.shared.userID else{return}
        print(String(id))
        let ref = Database.database().reference().child("\(id)")
        ref.child("dailyCalorie").observeSingleEvent(of: .value, with: { [self] (snapshot) in
            let dailyCalorie = snapshot.value as? Double ?? 0.0
            print("Daily Calorie: \(dailyCalorie)")
            UserInfoManager.shared.userDailyCalorie = dailyCalorie
            self.label.text = "günlük hedefini aşmaya \(dailyCalorie-total) kalorie kaldı"
            self.total = 0.0
        }) { (error) in
            print(error.localizedDescription)
        }
     
    }
    
}
