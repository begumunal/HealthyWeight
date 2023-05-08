//
//  OnboardingViewController.swift
//  HealthyWeight
//
//  Created by Begum Unal on 2.05.2023.
//

import UIKit

class OnboardingViewController: UIViewController {

    private var pointIcon = CustomIcon(image: AppImages.firstPointIcon, width: 32, height: 32)
    private let tripleImageView = TripleImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 396))
    private let signUpButton = CustomButton(buttonTitle: Constants.onboardingButtonText)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    //görsel değişikliğine göre notification dinliyorum.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updatePointIconImage(_:)), name: Notification.Name(Constants.pointIconcUpdateNotificationName), object: nil)
    }
    @objc func updatePointIconImage(_ notification: Notification) {
        guard let selectedIconName = notification.object as? UIImage else { return }
        pointIcon.image = selectedIconName
    }
    // Notification'ı kaldırıyoruz
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name(Constants.pointIconcUpdateNotificationName), object: nil)
    }
    private func setup(){
        self.view.backgroundColor = AppColors.barGreen
        self.tripleImageView.backgroundColor = AppColors.mainColor
        self.tripleImageView.translatesAutoresizingMaskIntoConstraints = false
        self.signUpButton.translatesAutoresizingMaskIntoConstraints = false
        self.pointIcon.translatesAutoresizingMaskIntoConstraints = false
        
        self.signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        
        view.addSubview(self.tripleImageView)
        view.addSubview(self.signUpButton)
        view.addSubview(self.pointIcon)
        
        NSLayoutConstraint.activate([
            self.tripleImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 160),
            self.tripleImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.tripleImageView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width)),
            self.tripleImageView.heightAnchor.constraint(equalToConstant: 450)
        ])
        NSLayoutConstraint.activate([
            self.signUpButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            self.signUpButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.signUpButton.widthAnchor.constraint(equalToConstant: 304),
            self.signUpButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            self.pointIcon.topAnchor.constraint(equalTo: self.tripleImageView.bottomAnchor, constant: 40),
            self.pointIcon.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
           
        ])
    }

    @objc func signUpButtonTapped(){
    
        let nextVC = RegisterViewController()
        nextVC.modalPresentationStyle = .fullScreen
        navigationItem.backButtonTitle = ""
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        UIView.transition(with: self.navigationController!.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.navigationController?.pushViewController(nextVC, animated: false)
        }, completion: nil)
    
    }
    func setNewIconImage(_ image: UIImage?) {
        guard let image = image else { return }
        self.pointIcon.image = image
        
    }

}
