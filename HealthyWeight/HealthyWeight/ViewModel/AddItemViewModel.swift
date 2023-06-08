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
    func cameraButtonTapped()
    func calculateButtonTapped(calorie: CalorieProtocol?)
    func continueButtonTapped()
    func detect(image : UIImage)
}
final class AddItemViewModel{
    weak var view: IAddItemView?
}
extension AddItemViewModel: IAddItemViewModel{
    func detect(image: UIImage) {
        guard let model = try? VNCoreMLModel(for: MyFoodClassifier_1().model) else {
            fatalError("Failed to load model")
        }
        let request = VNCoreMLRequest(model: model) { request, error in
            if let results = request.results as? [VNClassificationObservation], let topResult = results.first {
                // En yüksek olasılıklı sınıfın adını yazdırın.
                self.view?.printFoodName(foodName: topResult.identifier)
       
            }
        }
        let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
        try? handler.perform([request])
    }
    
    func continueButtonTapped() {
        view?.saveFood()
        view?.goToTabBar()
    }
    
    func calculateButtonTapped(calorie: CalorieProtocol?) {
        guard let calorie = calorie?.calorieValue else {return}
        view?.printCalorie(calorie: calorie)
    }
    
    func cameraButtonTapped() {
        view?.makePresent()
    }
    
    func viewDidLoad() {
        view?.prepareView()
        view?.prepareImageView()
        view?.prepareToolBar()
        view?.prepareImagePicker()
        view?.prepareCameraButton()
        view?.prepareContinueButton()
        view?.prepareImageInfoLabel()
        view?.prepareImageCalorieLabel()
        view?.prepareCalculateButton()
    }
    
    
}
