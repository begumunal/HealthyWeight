//
//  RegisterViewController.swift
//  HealthyWeight
//
//  Created by Begum Unal on 2.05.2023.
//
import Foundation
import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase

enum SegmentedControllerItems{
    static let firstItem = "Kayıt Ol"
    static let secondItem = "Giriş Yap"
}

class RegisterViewController: UIViewController {
    
    var userId = ""
    var isWomen = true
    var motionState : Int = 0
    private let signUpView = SignUpView()
    private let loginView = LoginView()
   
    private let segmentedController : UISegmentedControl = {
        let segmentedController = UISegmentedControl(items: [SegmentedControllerItems.firstItem, SegmentedControllerItems.secondItem])
        segmentedController.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        segmentedController.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], for: .normal)
        segmentedController.backgroundColor = AppColors.mainColor
        segmentedController.selectedSegmentTintColor = AppColors.barGreen
        segmentedController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: AppColors.textColor], for: .normal)
        segmentedController.layer.borderWidth = 1
        //segmentedController.layer.cornerRadius = 24
        segmentedController.layer.borderColor = AppColors.barGreen?.cgColor
        return segmentedController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
           view.addGestureRecognizer(tapGesture)
        signUpView.genderSegmentedController.addTarget(self, action: #selector(genderSegmentedControlValueChanged(_:)), for: .valueChanged)
        signUpView.motionStatusSegmentedController.addTarget(self, action: #selector(motionStatusSegmentedControllerValueChanged(_:)), for: .valueChanged)
        navigationController?.navigationBar.tintColor = .white
        self.setup()
        
    }
    private func setup(){
       
        self.view.backgroundColor = AppColors.mainColor
        
        self.segmentedController.selectedSegmentIndex = 0
        self.signUpView.motionStatusSegmentedController.selectedSegmentIndex = 0
        self.signUpView.genderSegmentedController.selectedSegmentIndex = 0
        signUpView.isHidden = false
        loginView.isHidden = true
        signUpView.isUserInteractionEnabled = true
        loginView.isUserInteractionEnabled = false
       
        self.segmentedController.translatesAutoresizingMaskIntoConstraints = false
        self.signUpView.translatesAutoresizingMaskIntoConstraints = false
        self.loginView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(self.segmentedController)
        view.addSubview(self.signUpView)
        view.addSubview(self.loginView)
        
        self.view.bringSubviewToFront(signUpView)
       
        NSLayoutConstraint.activate([
            self.segmentedController.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            self.segmentedController.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.segmentedController.widthAnchor.constraint(equalToConstant: 240),
            self.segmentedController.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            self.signUpView.topAnchor.constraint(equalTo: self.segmentedController.bottomAnchor, constant: 32),
            self.signUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.signUpView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.signUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.signUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
        NSLayoutConstraint.activate([
            self.loginView.topAnchor.constraint(equalTo: self.segmentedController.bottomAnchor, constant: 32),
            self.loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        signUpView.signupButton.addTarget(self, action: #selector(self.signUpButtonTapped), for: .touchUpInside)
        
        loginView.loginButton.addTarget(self, action: #selector(self.loginButtonTapped), for: .touchUpInside)

    }
    

    @objc func loginButtonTapped() {

        if self.loginView.emailTextField.text != "" && self.loginView.passwordTextField.text != ""{
            Auth.auth().signIn(withEmail: self.loginView.emailTextField.text!, password: self.loginView.passwordTextField.text!) { (user, error) in
                if error == nil {
                    // Kullanıcı başarılı bir şekilde giriş yaptı
                    // Burada gerekli işlemleri yapabilirsiniz
                    let tabBar = UITabBarController()
                    let vc1 = TodayViewController()
                    let vc2 = HistoryViewController()
                    let vc3 = ProfileViewController()
                    
                    vc1.tabBarItem = UITabBarItem(title: Constants.todayVCTitle, image: UIImage(systemName: "calendar.badge.plus"), tag: 0)
                    vc2.tabBarItem = UITabBarItem(title: Constants.historyVCTitle, image: UIImage(systemName: "timer"), tag: 1)
                    vc3.tabBarItem = UITabBarItem(title: Constants.profileVCTitle, image: UIImage(systemName: "person"), tag: 2)
                    tabBar.setViewControllers([vc1, vc2, vc3], animated: false)
                    tabBar.modalPresentationStyle = .fullScreen
                    tabBar.tabBar.backgroundColor = AppColors.barGreen
                    tabBar.tabBar.tintColor = AppColors.textColor
                    self.present(tabBar, animated: true, completion: nil)
                } else {
                    // Kullanıcı henüz kayıtlı değil
                    //self.makeAlert(title: "", message: "Böyle bir kullanıcı yok. Bilgilerinizi kontrol ediniz.")
                }
                
            }
        }else{
            //self.makeAlert(title: "", message: "Geçerli bilgiler giriniz.")

        }
        
    }
    
    @objc func signUpButtonTapped() {
        if signUpView.emailTextField.text != "" && signUpView.passwordTextField.text != "" && signUpView.ageTextField.text != "" && signUpView.lengthTextField.text != "" && signUpView.currentWeightTextField.text != "" && signUpView.goalWeightTextField.text != ""{
            Auth.auth().signIn(withEmail: signUpView.emailTextField.text!, password: signUpView.passwordTextField.text!) { (user, error) in
                if error == nil {
                    // Kullanıcı zaten var
                   
                    //let alert = AlertView.makeAlertForErrors(message: "Girdiğiniz bilgiler zaten Kayıtlı!")
                    //view.addSubview(alert)
                    //view.bringSubviewToFront(alert)
        
                } else {
                    // Kullanıcı henüz kayıtlı değil
                    // Yeni bir kullanıcı kaydedebilirsiniz
                    Auth.auth().createUser(withEmail: self.signUpView.emailTextField.text!, password: self.signUpView.passwordTextField.text!) { authResult, error in
                      if let error = error {
                        print("Kayıt başarısız oldu: \(error.localizedDescription)")
                          
                      } else {
                          guard let userId = authResult?.user.uid else { return }
                          self.userId = userId
                          print("Kullanıcı kaydı başarılı")

                          self.saveInfo()
                      }
                    }
                }
            }
        }else{
            //self.makeAlert(title: "", message: "Geçerli bilgiler giriniz.")
        }
    }
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.view.bringSubviewToFront(signUpView)
            signUpView.isHidden = false
            loginView.isHidden = true
            signUpView.isUserInteractionEnabled = true
            loginView.isUserInteractionEnabled = false
        case 1:
            self.view.bringSubviewToFront(loginView)
            signUpView.isHidden = true
            loginView.isHidden = false

            loginView.isUserInteractionEnabled = true
            signUpView.isUserInteractionEnabled = false
        default:
            break
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
    
    func saveInfo(){

        let age = Int(self.signUpView.ageTextField.text!)
        let length = Int(self.signUpView.lengthTextField.text!)
        let currentWeight = Int(self.signUpView.currentWeightTextField.text!)
        let goalWeight = Int(self.signUpView.goalWeightTextField.text!)
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
           
            print(self.userId)
            Database.database().reference().child(self.userId).setValue(["length" : user.length,"goalWight" : user.goalWeight, "isWomen" : user.isWomen, "age" : user.age, "currentWeight" : user.currentWeight, "dailyCalorie" : user.dailyCalorie, "motionState" : user.motionState])
            
            print("kullanıcı bilgileri kaydedildi.")
            
        } catch {
            print(error.localizedDescription)
            print("kullanıcı bilgileri kaydedilirken sorun yaşandı.")
        }
        
    }
}
