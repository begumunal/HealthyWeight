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

protocol IProfileView: AnyObject{
    func prepareView()
    func prepareToolBar()
    func prepareDailyCalorieLabel()
    func prepareDailyCalorieTextLabel()
    func prepareEditButton()
    func makePresent()
    func fetchData()
}
final class ProfileViewController: UIViewController {
    lazy var viewModel = ProfileViewModel()
    private let toolBar = UIToolbar()
    private let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
    let dailyCalorieLabel = UILabel()
    private let dailyCalorieTextLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
        self.fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewWillAppear()
    }
    override func viewDidAppear(_ animated: Bool) {
        viewModel.viewDidAppear()
    }

    @objc func editButtonTapped(){
        
        viewModel.editButtonTapped()
    }
}

extension ProfileViewController: IProfileView{
    func prepareEditButton() {
        editButton.tintColor = AppColors.textColor
    }
    
    func makePresent() {
        self.present(EditProfileViewController(), animated: true, completion: nil)
 
    }
    
    func prepareView() {
        view.backgroundColor = AppColors.mainColor
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        dailyCalorieLabel.translatesAutoresizingMaskIntoConstraints = false
        dailyCalorieTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(toolBar)
        view.addSubview(dailyCalorieLabel)
        view.addSubview(dailyCalorieTextLabel)
    }
    
    func prepareToolBar() {
        toolBar.barTintColor = AppColors.barGreen
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), editButton]
        NSLayoutConstraint.activate([
            toolBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            toolBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toolBar.widthAnchor.constraint(equalToConstant: view.frame.width),
            toolBar.heightAnchor.constraint(equalToConstant: 80)
        ])
        
    }
    
    func prepareDailyCalorieLabel() {
        dailyCalorieLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        dailyCalorieLabel.textColor = AppColors.textColor
        NSLayoutConstraint.activate([
            dailyCalorieLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dailyCalorieLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func prepareDailyCalorieTextLabel() {
        dailyCalorieTextLabel.text = Constants.dailyCalorieTextLabel
        dailyCalorieTextLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        dailyCalorieTextLabel.textColor = AppColors.textColor
        NSLayoutConstraint.activate([
            dailyCalorieTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dailyCalorieTextLabel.bottomAnchor.constraint(equalTo: dailyCalorieLabel.topAnchor, constant: -30)
        ])
    }
    func fetchData(){
        guard let id = UserInfoManager.shared.userID else{return}
        print(String(id))
        let ref = Database.database().reference().child("\(id)")
        ref.child("dailyCalorie").observeSingleEvent(of: .value, with: { (snapshot) in
            let dailyCalorie = snapshot.value as? Double ?? 0.0
            print("Daily Calorie: \(dailyCalorie)")
            UserInfoManager.shared.userDailyCalorie = dailyCalorie
            self.dailyCalorieLabel.text = String(dailyCalorie)
        }) { (error) in
            print(error.localizedDescription)
        }
     
    }
    
}
