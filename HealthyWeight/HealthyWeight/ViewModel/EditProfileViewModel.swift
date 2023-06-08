//
//  EditProfileViewModel.swift
//  HealthyWeight
//
//  Created by Begum Unal on 5.06.2023.
//

import Foundation
import UIKit

protocol IEditProfileViewModel{
    var view: IEditProfileView? { get set }
    func viewDidLoad()
    func updateButtonTapped(age: String, length: String, currentWeight: String, goalWeight: String)
    func genderSegmentedControlValueChanged(_ sender: UISegmentedControl)
    func motionStatusSegmentedControllerValueChanged(_ sender: UISegmentedControl)
}
final class EditProfileViewModel{
    weak var view: IEditProfileView?
}
extension EditProfileViewModel: IEditProfileViewModel{
    func updateButtonTapped(age: String, length: String, currentWeight: String, goalWeight: String) {
        if !(age.isEmpty && length.isEmpty && currentWeight.isEmpty && goalWeight.isEmpty){
            view?.updateInfo()
        }else{
            //BURAYA ALERT EKLE
        }
    }
    
    func genderSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            view?.decideGender(isWomen: true)
        case 1:
            view?.decideGender(isWomen: false)
        default:
            break
        }
    }
    
    func motionStatusSegmentedControllerValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            view?.decideMotionState(choice: 0)
        case 1:
            view?.decideMotionState(choice: 1)
        case 2:
            view?.decideMotionState(choice: 2)
        case 3:
            view?.decideMotionState(choice: 3)
        default:
            break
        }
    }
    
    func viewDidLoad() {
        view?.prepareView()
        view?.prepareUpdateButton()
        view?.prepareUserInfoView()
    }
    
    
}
