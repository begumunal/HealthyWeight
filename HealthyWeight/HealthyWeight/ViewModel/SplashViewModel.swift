//
//  SplashViewModel.swift
//  HealthyWeight
//
//  Created by Begum Unal on 5.06.2023.
//

import Foundation

protocol ISplashViewModel{
    var view: ISplashView? { get set }
    func viewDidLoad()
    func viewDidAppear(_ animated: Bool)
}
final class SplashViewModel{
    weak var view: ISplashView?
}
extension SplashViewModel: ISplashViewModel{
    func viewDidAppear(_ animated: Bool) {
        view?.showAnimation(animated)
    }
    
    func viewDidLoad() {
        view?.prepareView()
        view?.prepareSplashImage()
    }
    
    
}
