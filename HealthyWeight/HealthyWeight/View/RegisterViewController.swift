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

protocol IRegisterView: AnyObject{
    func prepareView()
    func prepareSegmentedController()
    func prepareSignUpView()
    func prepareLoginView()
    func showAlert(message: String)
    func presentToTabBar()
    func userRegistrationSuccess(userId: String)
    func saveInfo()
    func motionStatusValueChanged(_ sender: UISegmentedControl)
    func genderValueChanged(_ sender: UISegmentedControl)
    func viewChanged(_ sender: UISegmentedControl)
}
final class RegisterViewController: UIViewController {
    lazy var viewModel = RegisterViewModel()
    var userId = ""
    var isWomen = true
    var motionState : Int = 0
    let signUpView = SignUpView()
    let loginView = LoginView()
   
    private let segmentedController = UISegmentedControl(items: [SegmentedControllerItems.firstItem, SegmentedControllerItems.secondItem])
      
       
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    @objc func loginButtonTapped() {

        viewModel.loginButtonTapped(emailText: loginView.emailTextField.text!, passwordText: loginView.passwordTextField.text!)
      
    }
    
    @objc func signUpButtonTapped() {
        
        viewModel.signUpButtonTapped(email: signUpView.emailTextField.text!, password: signUpView.passwordTextField.text!, age: signUpView.ageTextField.text!, length: signUpView.lengthTextField.text!, currentWeight: signUpView.currentWeightTextField.text!, goalWeight: signUpView.goalWeightTextField.text!)
    }
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        viewModel.segmentedControlValueChanged(sender)
    }
    @objc func genderSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        viewModel.genderSegmentedControlValueChanged(sender)
    }
    @objc func motionStatusSegmentedControllerValueChanged(_ sender: UISegmentedControl) {
        viewModel.motionStatusSegmentedControllerValueChanged(sender)
    }
    
   
}

extension RegisterViewController: IRegisterView{
    func viewChanged(_ sender: UISegmentedControl) {
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
    
    func genderValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.isWomen = true
        case 1:
            self.isWomen = false
        default:
            break
        }
    }
    
    func motionStatusValueChanged(_ sender: UISegmentedControl) {
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
    
    func userRegistrationSuccess(userId: String) {
        self.userId = userId
        print("Kullanıcı kaydı başarılı")

        AlertView.makeAlert(title: "", message: "Kullanıcı kaydı başarılı. Giriş Yapınız", viewC: self)
    }
    
    func presentToTabBar() {
        let tabBar = CustomTabBarController()
        UIView.transition(with: self.navigationController!.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.navigationController?.pushViewController(tabBar, animated: false)
            self.navigationController?.isNavigationBarHidden = true
        }, completion: nil)
    }
    
    
    func prepareView() {
        view.backgroundColor = AppColors.mainColor
        navigationController?.navigationBar.tintColor = .white
        view.bringSubviewToFront(signUpView)
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
           view.addGestureRecognizer(tapGesture)

       segmentedController.translatesAutoresizingMaskIntoConstraints = false
       signUpView.translatesAutoresizingMaskIntoConstraints = false
       loginView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(segmentedController)
        view.addSubview(signUpView)
        view.addSubview(loginView)
    }
    
    func prepareSegmentedController() {
        segmentedController.selectedSegmentIndex = 0
        segmentedController.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        segmentedController.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], for: .normal)
        segmentedController.backgroundColor = AppColors.mainColor
        segmentedController.selectedSegmentTintColor = AppColors.barGreen
        segmentedController.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: AppColors.textColor!], for: .normal)
        segmentedController.layer.borderWidth = 1
        //segmentedController.layer.cornerRadius = 24
        segmentedController.layer.borderColor = AppColors.barGreen?.cgColor
        
        NSLayoutConstraint.activate([
            segmentedController.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            segmentedController.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedController.widthAnchor.constraint(equalToConstant: 240),
            segmentedController.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func prepareSignUpView() {
        signUpView.signupButton.addTarget(self, action: #selector(self.signUpButtonTapped), for: .touchUpInside)
        signUpView.genderSegmentedController.addTarget(self, action: #selector(genderSegmentedControlValueChanged(_:)), for: .valueChanged)
        signUpView.motionStatusSegmentedController.addTarget(self, action: #selector(motionStatusSegmentedControllerValueChanged(_:)), for: .valueChanged)
        signUpView.motionStatusSegmentedController.selectedSegmentIndex = 0
        signUpView.genderSegmentedController.selectedSegmentIndex = 0
        signUpView.isHidden = false
        signUpView.isUserInteractionEnabled = true
        NSLayoutConstraint.activate([
            signUpView.topAnchor.constraint(equalTo: segmentedController.bottomAnchor, constant: 32),
            signUpView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            signUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
    }
    
    func prepareLoginView() {
        loginView.isHidden = true
        loginView.isUserInteractionEnabled = false
        loginView.loginButton.addTarget(self, action: #selector(self.loginButtonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: segmentedController.bottomAnchor, constant: 32),
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func showAlert(message: String) {
        let alertView = AlertView.makeAlertForErrors(message: message)
        self.view.addSubview(alertView)
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
