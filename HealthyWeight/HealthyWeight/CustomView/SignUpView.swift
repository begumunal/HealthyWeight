//
//  SignUpView.swift
//  HealthyWeight
//
//  Created by Begum Unal on 2.05.2023.
//

import Foundation
import UIKit


enum GenderSegmentedControllerItems{
    static let firstItem = "Kadın"
    static let secondItem = "Erkek"
}
enum motionStatusSegmentedControllerItems{
    static let little = "Az"
    static let light = "Hafif"
    static let middle = "Orta"
    static let much = "Çok"
}
class SignUpView: UIView {
    
    let genderSegmentedController : UISegmentedControl = {
        let segmentedController = UISegmentedControl(items: [GenderSegmentedControllerItems.firstItem, GenderSegmentedControllerItems.secondItem])
        segmentedController.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        segmentedController.backgroundColor = AppColors.mainColor
        segmentedController.selectedSegmentTintColor = AppColors.barGreen
        segmentedController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: AppColors.textColor!], for: .normal)
        segmentedController.layer.borderWidth = 0.3
        segmentedController.layer.borderColor = AppColors.barGreen?.cgColor
        return segmentedController
    }()
    let ageTextField = CustomTextField(keyboardType: .default, text: "Yaş")
    let lengthTextField = CustomTextField(keyboardType: .default, text: "Boy")
    let currentWeightTextField = CustomTextField(keyboardType: .default, text: "Mevcut Kilo")
    let goalWeightTextField = CustomTextField(keyboardType: .default, text: "Hedef Kilo")
    private let motionStatusLabel : UILabel = {
        let label = UILabel()
        label.text = "Hareket Durumu:"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = AppColors.textColor
        return label
    }()
    let motionStatusSegmentedController : UISegmentedControl = {
        let segmentedController = UISegmentedControl(items: [motionStatusSegmentedControllerItems.little, motionStatusSegmentedControllerItems.light, motionStatusSegmentedControllerItems.middle, motionStatusSegmentedControllerItems.much])
        
        segmentedController.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        segmentedController.backgroundColor = AppColors.mainColor
        segmentedController.selectedSegmentTintColor = AppColors.barGreen
        segmentedController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: AppColors.textColor!], for: .normal)
        segmentedController.layer.borderWidth = 0.3
        segmentedController.layer.borderColor = AppColors.barGreen?.cgColor
        return segmentedController
    }()
    
    
    let emailTextField = CustomTextField(keyboardType: .emailAddress, text: "Email")
    let passwordTextField = CustomTextField(keyboardType: .default, text: "Parola")
    
    let signupButton = CustomButton(buttonTitle: Constants.signUpButtonText)
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = AppColors.mainColor
        self.passwordTextField.isSecureTextEntry = false 

        self.addSubview(emailTextField)
        self.addSubview(passwordTextField)
        self.addSubview(signupButton)
        self.addSubview(motionStatusLabel)
        self.addSubview(motionStatusSegmentedController)
        self.addSubview(ageTextField)
        self.addSubview(lengthTextField)
        self.addSubview(currentWeightTextField)
        self.addSubview(goalWeightTextField)
        self.addSubview(genderSegmentedController)

        self.emailTextField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.signupButton.translatesAutoresizingMaskIntoConstraints = false
        self.motionStatusSegmentedController.translatesAutoresizingMaskIntoConstraints = false
        self.ageTextField.translatesAutoresizingMaskIntoConstraints = false
        self.lengthTextField.translatesAutoresizingMaskIntoConstraints = false
        self.currentWeightTextField.translatesAutoresizingMaskIntoConstraints = false
        self.goalWeightTextField.translatesAutoresizingMaskIntoConstraints = false
        self.motionStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        self.genderSegmentedController.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.genderSegmentedController.widthAnchor.constraint(equalToConstant: 198),
            self.genderSegmentedController.heightAnchor.constraint(equalToConstant: 32),
            self.genderSegmentedController.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.ageTextField.widthAnchor.constraint(equalToConstant: 342),
            self.ageTextField.heightAnchor.constraint(equalToConstant: 44),
            self.ageTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.ageTextField.topAnchor.constraint(equalTo: self.genderSegmentedController.bottomAnchor, constant: 16),
            
            self.lengthTextField.widthAnchor.constraint(equalToConstant: 342),
            self.lengthTextField.heightAnchor.constraint(equalToConstant: 44),
            self.lengthTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.lengthTextField.topAnchor.constraint(equalTo: self.ageTextField.bottomAnchor, constant: 16),
            
            self.currentWeightTextField.widthAnchor.constraint(equalToConstant: 342),
            self.currentWeightTextField.heightAnchor.constraint(equalToConstant: 44),
            self.currentWeightTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.currentWeightTextField.topAnchor.constraint(equalTo: self.lengthTextField.bottomAnchor, constant: 16),
            
            self.goalWeightTextField.widthAnchor.constraint(equalToConstant: 342),
            self.goalWeightTextField.heightAnchor.constraint(equalToConstant: 44),
            self.goalWeightTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.goalWeightTextField.topAnchor.constraint(equalTo: self.currentWeightTextField.bottomAnchor, constant: 16),
            
            self.motionStatusLabel.widthAnchor.constraint(equalToConstant: 342),
            self.motionStatusLabel.heightAnchor.constraint(equalToConstant: 44),
            self.motionStatusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 3),
            self.motionStatusLabel.topAnchor.constraint(equalTo: self.goalWeightTextField.bottomAnchor, constant: 16),
            
            self.motionStatusSegmentedController.widthAnchor.constraint(equalToConstant: 200),
            self.motionStatusSegmentedController.heightAnchor.constraint(equalToConstant: 32),
            self.motionStatusSegmentedController.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.motionStatusSegmentedController.topAnchor.constraint(equalTo: self.motionStatusLabel.bottomAnchor, constant: 3),
            
            self.emailTextField.widthAnchor.constraint(equalToConstant: 342),
            self.emailTextField.heightAnchor.constraint(equalToConstant: 44),
            self.emailTextField.topAnchor.constraint(equalTo: self.motionStatusSegmentedController.bottomAnchor, constant: 16),
            self.emailTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.passwordTextField.widthAnchor.constraint(equalToConstant: 342),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            self.passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 16),
            self.passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.signupButton.widthAnchor.constraint(equalToConstant: 304),
            self.signupButton.heightAnchor.constraint(equalToConstant: 40),
            self.signupButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 50),
            self.signupButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

