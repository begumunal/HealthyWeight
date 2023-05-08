//
//  AddItemViewController.swift
//  HealthyWeight
//
//  Created by Begum Unal on 3.05.2023.
//

import UIKit
import CoreML
import Vision

class AddItemViewController: UIViewController{
    
    var calorie = Double()
    let networkService = NetworkService()
    let networkManager = NetworkManager()
    var imagePicker = UIImagePickerController()
    private let toolBar = UIToolbar()
    private let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(cameraButtonTapped))
    private let continueButton = CustomButton(buttonTitle: "Devam Et")
    private let calculateButton = CustomButton(buttonTitle: "Hesapla")
    private let imageInfoLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = AppColors.textColor
        return label
    }()
    let imageCalorieLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = AppColors.textColor
        return label
    }()
    private let imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColors.mainColor
        
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = false
        self.imagePicker.sourceType = .camera
        
        self.setup()
    }
    
    func setup(){
        cameraButton.tintColor = AppColors.textColor
        //toolBar.backgroundColor = AppColors.barGreen
        toolBar.barTintColor = AppColors.barGreen
        imageView.backgroundColor = AppColors.barGreen
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), cameraButton]
        self.calculateButton.addTarget(self, action: #selector(calculateButtonTapped), for: .touchUpInside)
        self.toolBar.translatesAutoresizingMaskIntoConstraints = false
        self.imageInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageCalorieLabel.translatesAutoresizingMaskIntoConstraints = false
        self.continueButton.translatesAutoresizingMaskIntoConstraints = false
        self.calculateButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(toolBar)
        view.addSubview(self.imageInfoLabel)
        view.addSubview(self.imageView)
        view.addSubview(self.imageCalorieLabel)
        view.addSubview(self.continueButton)
        view.addSubview(self.calculateButton)
        
        NSLayoutConstraint.activate([
            self.toolBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            self.toolBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.toolBar.widthAnchor.constraint(equalToConstant: view.frame.width),
            self.toolBar.heightAnchor.constraint(equalToConstant: 80),
     
            self.imageInfoLabel.topAnchor.constraint(equalTo: self.toolBar.bottomAnchor, constant: 30),
            self.imageInfoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            self.imageView.topAnchor.constraint(equalTo: self.imageInfoLabel.topAnchor, constant: 20),
            self.imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.imageView.widthAnchor.constraint(equalToConstant: view.frame.width),
            self.imageView.heightAnchor.constraint(equalToConstant: 400),
            
            self.imageCalorieLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20),
            self.imageCalorieLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           
            
            self.calculateButton.widthAnchor.constraint(equalToConstant: 200),
            self.calculateButton.heightAnchor.constraint(equalToConstant: 40),
            self.calculateButton.topAnchor.constraint(equalTo: self.imageCalorieLabel.bottomAnchor, constant: 50),
            self.calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            self.continueButton.widthAnchor.constraint(equalToConstant: 304),
            self.continueButton.heightAnchor.constraint(equalToConstant: 40),
            self.continueButton.topAnchor.constraint(equalTo: self.calculateButton.bottomAnchor, constant: 50),
            self.continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
        ])
        
    }
    override func viewWillAppear(_ animated: Bool) {
        print(self.calorie)
        self.imageCalorieLabel.text = String(self.calorie)
    }
    func detect(image : UIImage){
        
        guard let model = try? VNCoreMLModel(for: MyFoodClassifier_1().model) else {
            fatalError("Failed to load model")
        }
        let request = VNCoreMLRequest(model: model) { request, error in
            if let results = request.results as? [VNClassificationObservation], let topResult = results.first {
                // En yüksek olasılıklı sınıfın adını yazdırın.
                print("En yüksek olasılıklı sınıf: \(topResult.identifier)")
                self.imageInfoLabel.text = topResult.identifier
                
                self.networkService.getCalorie(query: topResult.identifier)
            
                
                
            }
            
        }
        let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
        try? handler.perform([request])
        print(calorie)
        self.imageCalorieLabel.text = String(calorie)
        /*if let calorie = calorie {
            print(calorie)
            self.imageCalorieLabel.text = String(calorie)
        }*/
    }
    @objc func cameraButtonTapped(){
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func calculateButtonTapped(){
        print(calorie)
        self.imageCalorieLabel.text = String(calorie)
    }

}
extension AddItemViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            /*guard let convertedCIImage = CIImage(image: userPickedImage)else {
                fatalError("connot convert to CIImage")
            }*/
            detect(image: userPickedImage)
            self.imageView.image = userPickedImage
            self.imagePicker.dismiss(animated: true,completion: nil)
        }
    }
}
