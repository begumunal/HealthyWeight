//
//  EditProfileViewController.swift
//  HealthyWeight
//
//  Created by Begum Unal on 8.05.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

class EditProfileViewController: UIViewController {
    private var isWomen = true
    private var motionState : Int = 0
    private let userInfoView = SignUpView()
    private let updateButton = CustomButton(buttonTitle: Constants.editProfileButtonTitle)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInfoView.signupButton.layer.opacity = 0
        userInfoView.emailTextField.layer.opacity = 0
        userInfoView.passwordTextField.layer.opacity = 0
        setup()
    }
    
    func setup(){
        userInfoView.genderSegmentedController.addTarget(self, action: #selector(genderSegmentedControlValueChanged(_:)), for: .valueChanged)
        userInfoView.motionStatusSegmentedController.addTarget(self, action: #selector(motionStatusSegmentedControllerValueChanged(_:)), for: .valueChanged)
        self.updateButton.addTarget(self, action: #selector(self.updateButtonTapped), for: .touchUpInside)
        self.userInfoView.motionStatusSegmentedController.selectedSegmentIndex = 0
        self.userInfoView.genderSegmentedController.selectedSegmentIndex = 0
        
        self.view.backgroundColor = AppColors.mainColor
        self.updateButton.translatesAutoresizingMaskIntoConstraints = false
        self.userInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(self.userInfoView)
        view.addSubview(self.updateButton)
        
        NSLayoutConstraint.activate([
            self.userInfoView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
            self.userInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.userInfoView.widthAnchor.constraint(equalToConstant: view.frame.width),
            self.userInfoView.heightAnchor.constraint(equalToConstant: 400),
            
            self.updateButton.widthAnchor.constraint(equalToConstant: 200),
            self.updateButton.heightAnchor.constraint(equalToConstant: 40),
            self.updateButton.topAnchor.constraint(equalTo: self.userInfoView.bottomAnchor, constant: 60),
            self.updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
       
        ])
    }

    @objc func updateButtonTapped(){
        if userInfoView.ageTextField.text != "" && userInfoView.lengthTextField.text != "" && userInfoView.currentWeightTextField.text != "" && userInfoView.goalWeightTextField.text != "" {
            
            self.updateInfo()
            
        }
    }
    @objc func genderSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.isWomen = true
        case 1:
            self.isWomen = false
        default:
            break
        }
    }
    @objc func motionStatusSegmentedControllerValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("az")
            self.motionState = 0
        case 1:
            print("hafif")
            self.motionState = 1
        case 2:
            print("orta")
            self.motionState = 2
        case 3:
            print("çok")
            self.motionState = 3
        default:
            break
        }
    }
    func updateInfo(){

        let age = Int(self.userInfoView.ageTextField.text!)
        let length = Int(self.userInfoView.lengthTextField.text!)
        let currentWeight = Int(self.userInfoView.currentWeightTextField.text!)
        let goalWeight = Int(self.userInfoView.goalWeightTextField.text!)
        var i = 0.0
        var dailyCalorie = 0.0
        
        if isWomen{
            i = 10.0 * Double(currentWeight!) + 6.25 * Double(length!) - 5.0 * Double(age!) - 161.0
        }else{
            i = 10.0 * Double(currentWeight!) + 6.25 * Double(length!) - 5.0 * Double(age!) + 5.0
        }
        switch self.motionState{
        case 0:
            dailyCalorie = i * 1.2
        case 1:
            dailyCalorie = i * 1.375
        case 2:
            dailyCalorie = i * 1.55
        case 3:
            dailyCalorie = i * 1.725
        default:
            break
        }
        
        if currentWeight! > goalWeight!{
            dailyCalorie -= 500.0
        }else if currentWeight! < goalWeight!{
            dailyCalorie += 500.0
        }else{

        }
    
        let user = UserModel(age: age!, length: length!, currentWeight: currentWeight!, goalWeight: goalWeight!, isWomen: isWomen, motionState: motionState, dailyCalorie: dailyCalorie)
        do {
            let ref = Database.database().reference()

            guard let id = UserInfoManager.shared.userID else {return}
            // Kullanıcının kaydını temsil eden belirli bir düğümü seçin
            let userRef = ref.child(id)

            // Kullanıcının adını ve soyadını güncelleyin
            userRef.updateChildValues(["length" : user.length,"goalWight" : user.goalWeight, "isWomen" : user.isWomen, "age" : user.age, "currentWeight" : user.currentWeight, "dailyCalorie" : user.dailyCalorie, "motionState" : user.motionState])

           
            print("kullanıcı bilgileri güncellendi.")
            AlertView.makeAlert(title: "", message: "Bilgilerini güncellendi", viewC: self)
        } catch {
            print(error.localizedDescription)
            print("kullanıcı bilgileri kaydedilirken sorun yaşandı.")
        }
        
    }
}
