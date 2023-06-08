//
//  ProfileViewModel.swift
//  HealthyWeight
//
//  Created by Begum Unal on 5.06.2023.
//

import Foundation

protocol IProfileViewModel{
    var view: IProfileView? { get set }
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func editButtonTapped()
}
final class ProfileViewModel{
    weak var view: IProfileView?
}
extension ProfileViewModel: IProfileViewModel{
    func viewWillAppear() {
        view?.fetchData()
    }
    
    func viewDidAppear() {
        view?.fetchData()
    }
    
    func editButtonTapped() {
        view?.makePresent()
    }
    
    func viewDidLoad() {
        view?.prepareView()
        view?.prepareToolBar()
        view?.prepareDailyCalorieLabel()
        view?.prepareDailyCalorieTextLabel()
        view?.prepareEditButton()
    }
    
    
}
