//
//  OnboardingViewController.swift
//  HealthyWeight
//
//  Created by Begum Unal on 2.05.2023.
//

import UIKit
protocol IOnboardingView: AnyObject, SeguePerformable{
    func prepareView()
    func preparePointIcon()
    func prepareTripleImageView()
    func prepareSignUpButton()
    func listenImageChange(_ animated: Bool)
    func endListen(_ animated: Bool)
    func goToRegister()
    func updatePointIcon(selectedIconName: UIImage)
}
class OnboardingViewController: UIViewController {

    lazy var viewModel = OnboardingViewModel()
    private var pointIcon = CustomIcon(image: AppImages.firstPointIcon, width: 32, height: 32)
    private let tripleImageView = TripleImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 396))
    private let signUpButton = CustomButton(buttonTitle: Constants.onboardingButtonText)
   
    override func viewDidLoad() {
        super.viewDidLoad()
     
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    //görsel değişikliğine göre notification dinliyorum.
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewWillAppear(animated)
    }
    @objc func updatePointIconImage(_ notification: Notification) {
        
        viewModel.updatePointIconImage(notification)
    }
    // Notification'ı kaldırıyoruz
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.viewWillDisappear(animated)
    }
   
    @objc func signUpButtonTapped(){
    
        viewModel.signUpButtonTapped()
    }
   
}

extension OnboardingViewController: IOnboardingView{
    func updatePointIcon(selectedIconName: UIImage) {
        pointIcon.image = selectedIconName
    }
    
    func goToRegister() {
        let nextVC = RegisterViewController()
        makePushVC(nextVC: nextVC)
    }
    
    func listenImageChange(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updatePointIconImage(_:)), name: Notification.Name(Constants.pointIconcUpdateNotificationName), object: nil)
    }
    
    func endListen(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name(Constants.pointIconcUpdateNotificationName), object: nil)
    }
    
    func prepareView() {
        view.backgroundColor = AppColors.barGreen
        tripleImageView.backgroundColor = AppColors.mainColor
        tripleImageView.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        pointIcon.translatesAutoresizingMaskIntoConstraints = false
        
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        
        view.addSubview(tripleImageView)
        view.addSubview(signUpButton)
        view.addSubview(pointIcon)
    }
    
    func preparePointIcon() {
        NSLayoutConstraint.activate([
            self.pointIcon.topAnchor.constraint(equalTo: self.tripleImageView.bottomAnchor, constant: 40),
            self.pointIcon.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
           
        ])
    }
    
    func prepareTripleImageView() {
        NSLayoutConstraint.activate([
            self.tripleImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 160),
            self.tripleImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.tripleImageView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width)),
            self.tripleImageView.heightAnchor.constraint(equalToConstant: 450)
        ])
    }
    
    func prepareSignUpButton() {
        NSLayoutConstraint.activate([
            self.signUpButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            self.signUpButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.signUpButton.widthAnchor.constraint(equalToConstant: 304),
            self.signUpButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
}
