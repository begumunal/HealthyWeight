//
//  ViewController.swift
//  HealthyWeight
//
//  Created by Begum Unal on 2.05.2023.
//

import UIKit

class ViewController: UIViewController {

    private let splashImage = CustomIcon(image: AppImages.splashImage, width: 240, height: 60)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }

    private func setup(){
        self.view.backgroundColor = AppColors.barGreen
        
        self.splashImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(self.splashImage)
        
        NSLayoutConstraint.activate([
            self.splashImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.splashImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Animasyonlar tamamlandığında, yeni bir ViewController'a geçiş yapabilirsiniz.
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          
            let nextVC = OnboardingViewController()
            nextVC.modalPresentationStyle = .fullScreen
            self.navigationController?.setViewControllers([nextVC], animated: true)
           // self.present(nextVC, animated: false)
        }
    }

}

