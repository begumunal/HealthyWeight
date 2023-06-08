//
//  TodayViewModel.swift
//  HealthyWeight
//
//  Created by Begum Unal on 6.06.2023.
//

import Foundation
import UIKit
import CoreML
import Vision

protocol ITodayViewModel{
    var view: ITodayView? {get set}
    func viewDidLoad()
    func viewWillAppear()
    func addButtonTapped()
    func detect(image : UIImage)
}
final class TodayViewModel{
    weak var view: ITodayView?
}
extension TodayViewModel: ITodayViewModel{
    func viewDidLoad() {
        view?.prepareView()
        view?.prepareToolBar()
        view?.prepareLabel()
        view?.prepareAddButton()
        view?.prepareTableView()
        view?.prepareImagePicker()
    }
    
    func viewWillAppear() {
        view?.fetchTableViewData()
    }
    
    func addButtonTapped() {
        view?.makePresent()
    }
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
    
}
