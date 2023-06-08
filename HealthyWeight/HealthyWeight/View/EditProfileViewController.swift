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

protocol IEditProfileView: AnyObject{
    func prepareView()
    func prepareUserInfoView()
    func prepareUpdateButton()
    func updateInfo()
    func decideGender(isWomen: Bool)
    func decideMotionState(choice: Int)
}
final class EditProfileViewController: UIViewController {
    lazy var viewModel = EditProfileViewModel()
    
    private var isWomen = true
    private var motionState : Int = 0
    private let userInfoView = SignUpView()
    private let updateButton = CustomButton(buttonTitle: Constants.editProfileButtonTitle)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }

    @objc func updateButtonTapped(){
        viewModel.updateButtonTapped(age: userInfoView.ageTextField.text!, length: userInfoView.lengthTextField.text!, currentWeight: userInfoView.currentWeightTextField.text!, goalWeight: userInfoView.goalWeightTextField.text!)
    }
    
    @objc func genderSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        viewModel.genderSegmentedControlValueChanged(sender)
    }
    
    @objc func motionStatusSegmentedControllerValueChanged(_ sender: UISegmentedControl) {
        viewModel.motionStatusSegmentedControllerValueChanged(sender)
    }
}

extension EditProfileViewController: IEditProfileView{
    func decideMotionState(choice: Int) {
        self.motionState = choice
    }
    
    func decideGender(isWomen: Bool) {
        self.isWomen = isWomen
    }
    
    func prepareView() {
        view.backgroundColor = AppColors.mainColor
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        userInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(userInfoView)
        view.addSubview(updateButton)
    }
    
    func prepareUserInfoView() {
        userInfoView.signupButton.layer.opacity = 0
        userInfoView.emailTextField.layer.opacity = 0
        userInfoView.passwordTextField.layer.opacity = 0
        userInfoView.genderSegmentedController.addTarget(self, action: #selector(genderSegmentedControlValueChanged(_:)), for: .valueChanged)
        userInfoView.motionStatusSegmentedController.addTarget(self, action: #selector(motionStatusSegmentedControllerValueChanged(_:)), for: .valueChanged)
        userInfoView.motionStatusSegmentedController.selectedSegmentIndex = 0
        userInfoView.genderSegmentedController.selectedSegmentIndex = 0
        NSLayoutConstraint.activate([
           userInfoView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
           userInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           userInfoView.widthAnchor.constraint(equalToConstant: view.frame.width),
           userInfoView.heightAnchor.constraint(equalToConstant: 400),
       
        ])
    }
    
    func prepareUpdateButton() {
        updateButton.addTarget(self, action: #selector(self.updateButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            updateButton.widthAnchor.constraint(equalToConstant: 200),
            updateButton.heightAnchor.constraint(equalToConstant: 40),
            updateButton.topAnchor.constraint(equalTo: self.userInfoView.bottomAnchor, constant: 60),
            updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
       
        ])
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
