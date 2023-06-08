//
//  ViewController.swift
//  HealthyWeight
//
//  Created by Begum Unal on 2.05.2023.
//

import UIKit
protocol ISplashView: AnyObject{
    func prepareView()
    func prepareSplashImage()
    func showAnimation(_ animated: Bool)
}
final class SplashViewController: UIViewController {

    lazy var viewModel = SplashViewModel()
    private let splashImage = CustomIcon(image: AppImages.splashImage, width: 240, height: 60)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        viewModel.viewDidAppear(animated)
    }

}

extension SplashViewController: ISplashView{
    func showAnimation(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Animasyonlar tamamlandığında, yeni bir ViewController'a geçiş yapabilirsiniz.
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          
            let nextVC = OnboardingViewController()
            nextVC.modalPresentationStyle = .fullScreen
            self.navigationController?.setViewControllers([nextVC], animated: true)
           // self.present(nextVC, animated: false)
        }
    }
    
    func prepareView() {
        view.backgroundColor = AppColors.barGreen
        splashImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(splashImage)
    }
    
    func prepareSplashImage() {
        NSLayoutConstraint.activate([
            self.splashImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.splashImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
}
