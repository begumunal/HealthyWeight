//
//  LoginView.swift
//  HealthyWeight
//
//  Created by Begum Unal on 2.05.2023.
//

import Foundation
import UIKit
import AVFoundation

class LoginView : UIView{
    
    let loginButton = CustomButton(buttonTitle: Constants.loginButtonText)
    let emailTextField = CustomTextField(keyboardType: .emailAddress, text: "Email")
    let passwordTextField = CustomTextField(keyboardType: .default, text: "Parola")
    
    init() {
        super.init(frame: .zero)

        self.backgroundColor = AppColors.mainColor
        self.addSubview(emailTextField)
        self.addSubview(passwordTextField)
        self.addSubview(loginButton)
        
        self.emailTextField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
        self.passwordTextField.isSecureTextEntry = true
        NSLayoutConstraint.activate([
            
            self.emailTextField.widthAnchor.constraint(equalToConstant: 342),
            self.emailTextField.heightAnchor.constraint(equalToConstant: 44),
            self.emailTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.passwordTextField.widthAnchor.constraint(equalToConstant: 342),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            self.passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 16),
            self.passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.loginButton.widthAnchor.constraint(equalToConstant: 304),
            self.loginButton.heightAnchor.constraint(equalToConstant: 40),
            self.loginButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 50),
            self.loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
           
        ])
        
    }
   
    private func videoPlayer(){
       /* if let url = Bundle.main.url(forResource: "LoginViewVideo", withExtension: "mov") {
            let player = AVPlayer(url: url)
            let playerView = CustomVideoPlayer(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
            playerView.player = player
            self.addSubview(playerView)
            playerView.player?.play()
        }*/
    }
   
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
