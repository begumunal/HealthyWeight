//
//  OnboardingViewModel.swift
//  HealthyWeight
//
//  Created by Begum Unal on 5.06.2023.
//

import Foundation
import UIKit

protocol IOnboardingViewModel{
    var view: IOnboardingView? { get set }
    func viewDidLoad()
    func viewWillAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func signUpButtonTapped()
    func updatePointIconImage(_ notification: Notification)
}
final class OnboardingViewModel{
    weak var view: IOnboardingView?
}
extension OnboardingViewModel: IOnboardingViewModel{
    func updatePointIconImage(_ notification: Notification) {
        guard let selectedIconName = notification.object as? UIImage else { return }
        view?.updatePointIcon(selectedIconName: selectedIconName)
    }
    
    func viewWillDisappear(_ animated: Bool) {
        view?.endListen(animated)
    }
    
    func signUpButtonTapped() {
        view?.goToRegister()
    }
    
    func viewWillAppear(_ animated: Bool) {
        view?.listenImageChange(animated)
    }
    
    func viewDidLoad() {
        view?.prepareView()
        view?.preparePointIcon()
        view?.prepareSignUpButton()
        view?.prepareTripleImageView()
    }
    
    
}
