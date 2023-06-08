//
//  AddItemViewController.swift
//  HealthyWeight
//
//  Created by Begum Unal on 3.05.2023.
//

import UIKit
import CoreML
import Vision
import FirebaseAuth
import FirebaseDatabase

protocol IAddItemView: AnyObject{
    func prepareView()
    func prepareToolBar()
    func prepareContinueButton()
    func prepareImageInfoLabel()
    func prepareImageCalorieLabel()
    func prepareImageView()
    func saveFood()
    func goToTabBar()
}

final class AddItemViewController: UIViewController{
    lazy var viewModel = AddItemViewModel()
    private let toolBar = UIToolbar()
    private let continueButton = CustomButton(buttonTitle: "Devam Et")
    private let imageInfoLabel = UILabel()
    let imageCalorieLabel = UILabel()
    private let imageView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    @objc func continueButtonTapped(){
        viewModel.continueButtonTapped()
        
    }
}

extension AddItemViewController: IAddItemView{

    func goToTabBar() {
        let tabBar = CustomTabBarController()
        self.present(tabBar, animated: true)
    }

    func saveFood(){
        
        let image = self.imageView.image!
        let foodName = self.imageInfoLabel.text!
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {return}
        let base64String = imageData.base64EncodedString()
        let food = FoodModel(image: base64String, foodName: foodName, foodCalorie: UserInfoManager.shared.foodCalorie!)

        do{
            guard let currentUser = Auth.auth().currentUser else {return}
            let userID = currentUser.uid
            print(userID)
            
            Database.database().reference().child(userID).child("foods").child(UtilityFunctions.getDate()).child(UUID().uuidString).setValue(["image" : food.image, "foodName" : food.foodName, "foodCalorie" : food.foodCalorie])
            
            print("kaydedildi.")
            
            
        }catch {
            print(error.localizedDescription)
            print("kaydedilemedi.")
        }
    }
    func prepareView() {
        view.backgroundColor = AppColors.mainColor
        
        self.imageView.image = UserInfoManager.shared.foodImage
        self.imageInfoLabel.text = UserInfoManager.shared.foodName
        //self.imageCalorieLabel.text = String(UserInfoManager.shared.foodCalorie!)
        
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        imageInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageCalorieLabel.translatesAutoresizingMaskIntoConstraints = false
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toolBar)
        view.addSubview(imageInfoLabel)
        view.addSubview(imageView)
        view.addSubview(imageCalorieLabel)
        view.addSubview(continueButton)
  
    }
    func prepareImageView() {
        imageView.backgroundColor = AppColors.barGreen
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.imageInfoLabel.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: view.frame.width),
            imageView.heightAnchor.constraint(equalToConstant: 400),
        ])
    }

    func prepareToolBar() {
        toolBar.barTintColor = AppColors.barGreen
        NSLayoutConstraint.activate([
            toolBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            toolBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toolBar.widthAnchor.constraint(equalToConstant: view.frame.width),
            toolBar.heightAnchor.constraint(equalToConstant: 80),
        ])
       
    }

    func prepareContinueButton() {
        NSLayoutConstraint.activate([
            continueButton.widthAnchor.constraint(equalToConstant: 304),
            continueButton.heightAnchor.constraint(equalToConstant: 40),
            continueButton.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 50),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        self.continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    func prepareImageInfoLabel() {
        imageInfoLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        imageInfoLabel.textColor = AppColors.textColor
        NSLayoutConstraint.activate([
            imageInfoLabel.topAnchor.constraint(equalTo: self.toolBar.bottomAnchor, constant: 30),
            imageInfoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func prepareImageCalorieLabel() {
        imageCalorieLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        imageCalorieLabel.textColor = AppColors.textColor
        NSLayoutConstraint.activate([
            imageCalorieLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20),
            imageCalorieLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
    
    
}
