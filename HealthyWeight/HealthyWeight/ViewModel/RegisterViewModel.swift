//
//  RegisterViewModel.swift
//  HealthyWeight
//
//  Created by Begum Unal on 5.06.2023.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import UIKit

protocol IRegisterViewModel{
    var view: IRegisterView? { get set }
    func viewDidLoad()
    func loginButtonTapped(emailText: String, passwordText: String)
    func signUpButtonTapped(email: String, password: String, age: String, length: String, currentWeight: String, goalWeight: String)
    func motionStatusSegmentedControllerValueChanged(_ sender: UISegmentedControl)
    func genderSegmentedControlValueChanged(_ sender: UISegmentedControl)
    func segmentedControlValueChanged(_ sender: UISegmentedControl)
}
final class RegisterViewModel{
    weak var view: IRegisterView?
}
extension RegisterViewModel: IRegisterViewModel{
    func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        view?.viewChanged(sender)
    }
    
    func genderSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        view?.genderValueChanged(sender)
    }
    
    func motionStatusSegmentedControllerValueChanged(_ sender: UISegmentedControl) {
        view?.motionStatusValueChanged(sender)
    }
    
    func signUpButtonTapped(email: String, password: String, age: String, length: String, currentWeight: String, goalWeight: String) {
        if !email.isEmpty && !password.isEmpty && !age.isEmpty && !length.isEmpty && !currentWeight.isEmpty && !goalWeight.isEmpty{
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    // Kullanıcı zaten var
                    self.view?.showAlert(message: "Kullanıcı zaten kayıtlı")
        
                } else {
                    // Kullanıcı henüz kayıtlı değil
                    // Yeni bir kullanıcı kaydedebilirsiniz
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                      if let error = error {
                        print("Kayıt başarısız oldu: \(error.localizedDescription)")
                          
                      } else {
                          guard let userId = authResult?.user.uid else { return }
                          self.view?.userRegistrationSuccess(userId: userId)
                          self.view?.saveInfo()
                      }
                    }
                }
            }
        }else{
            view?.showAlert(message: "Lütfen geçerli bilgiler giriniz.")
        }
    }
    
    func loginButtonTapped(emailText: String, passwordText: String) {
        if !emailText.isEmpty && !passwordText.isEmpty{
            Auth.auth().signIn(withEmail: emailText, password: passwordText) { (user, error) in
                if error == nil {
                    self.view?.presentToTabBar()
                    if let user = Auth.auth().currentUser {
                        UserInfoManager.shared.userID = user.uid
                        
                    } else {
                      print("No user is currently logged in.")
                    }
                } else {
                    // Kullanıcı henüz kayıtlı değil
                    self.view?.showAlert(message: "Böyle bir kullanıcı yok.")
                }
            }
        }else{
            view?.showAlert(message: "Lütfen geçerli bilgiler giriniz.")
        }
    }
    

    func viewDidLoad() {
        view?.prepareView()
        view?.prepareLoginView()
        view?.prepareSignUpView()
        view?.prepareSegmentedController()
    }
    
    
}
