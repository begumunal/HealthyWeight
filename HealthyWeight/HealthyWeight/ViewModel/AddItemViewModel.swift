//
//  AddItemViewModel.swift
//  HealthyWeight
//
//  Created by Begum Unal on 5.06.2023.
//

import Foundation
import UIKit
import CoreML
import Vision

protocol IAddItemViewModel{
    var view: IAddItemView? { get set }
    func viewDidLoad()
    func continueButtonTapped()
}
final class AddItemViewModel{
    weak var view: IAddItemView?
}
extension AddItemViewModel: IAddItemViewModel{
 
    func continueButtonTapped() {
        view?.saveFood()
        view?.goToTabBar()
    }

    func viewDidLoad() {
        view?.prepareView()
        view?.prepareImageView()
        view?.prepareToolBar()
        view?.prepareContinueButton()
        view?.prepareImageInfoLabel()
        view?.prepareImageCalorieLabel()

    }
    
    
}
