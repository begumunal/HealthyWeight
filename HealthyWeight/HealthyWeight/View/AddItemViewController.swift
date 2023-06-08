//
//  AddItemViewController.swift
//  HealthyWeight
//
//  Created by Begum Unal on 3.05.2023.
//

import UIKit
import CoreML
import Vision
import FirebaseAuth
import FirebaseDatabase

protocol IAddItemView: AnyObject{
    func prepareView()
    func prepareImagePicker()
    func prepareToolBar()
    func prepareCameraButton()
    func prepareContinueButton()
    func prepareCalculateButton()
    func prepareImageInfoLabel()
    func prepareImageCalorieLabel()
    func prepareImageView()
    func makePresent()
    func printCalorie(calorie: Double?)
    func saveFood()
    func goToTabBar()
    func printFoodName(foodName: String)
}
final class AddItemViewController: UIViewController{
    lazy var viewModel = AddItemViewModel()
    private weak var calorie: CalorieProtocol?
    //var calorie : Double?
    let networkService = NetworkService()
    var imagePicker = UIImagePickerController()
    private let toolBar = UIToolbar()
    private let continueButton = CustomButton(buttonTitle: "Devam Et")
    private let calculateButton = CustomButton(buttonTitle: "Hesapla")
    private let imageInfoLabel = UILabel()
    let imageCalorieLabel = UILabel()
    private let imageView = UIImageView()
    private let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(cameraButtonTapped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    func detect(image : UIImage){
        viewModel.detect(image: image)
    }
    @objc func cameraButtonTapped(){
        viewModel.cameraButtonTapped()
    }
    @objc func continueButtonTapped(){
        viewModel.continueButtonTapped()
        
    }
    @objc func calculateButtonTapped(){
        
        viewModel.calculateButtonTapped(calorie: self.calorie)
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

extension AddItemViewController: IAddItemView{
    
    func printFoodName(foodName: String) {
        print("En yüksek olasılıklı sınıf: \(foodName)")
        self.imageInfoLabel.text = foodName
        
        self.networkService.getCalorie(query: foodName)
    }
    
    func goToTabBar() {
        let tabBar = CustomTabBarController()
        self.present(tabBar, animated: true)
    }
    
    func printCalorie(calorie: Double?) {
        print("\(calorie!)")
        self.imageCalorieLabel.text = "\(calorie!)"
    }
    
    func makePresent() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func saveFood(){
        
        let image = self.imageView.image!
        let foodName = self.imageInfoLabel.text!
        let foodCalorie = 540.8
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {return}
        let base64String = imageData.base64EncodedString()
        let food = FoodModel(image: base64String, foodName: foodName, foodCalorie: foodCalorie)

        do{
            guard let currentUser = Auth.auth().currentUser else {return}
            let userID = currentUser.uid
            print(userID)
            
            Database.database().reference().child(userID).child("foods").child(UtilityFunctions.getDate()).child(UUID().uuidString).setValue(["image" : food.image, "foodName" : food.foodName, "foodCalorie" : food.foodCalorie])
            
            print("kaydedildi.")
            
            
        }catch {
            print(error.localizedDescription)
            print("kaydedilemedi.")
        }
    }
    func prepareView() {
        view.backgroundColor = AppColors.mainColor
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        imageInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageCalorieLabel.translatesAutoresizingMaskIntoConstraints = false
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        calculateButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toolBar)
        view.addSubview(imageInfoLabel)
        view.addSubview(imageView)
        view.addSubview(imageCalorieLabel)
        view.addSubview(continueButton)
        view.addSubview(calculateButton)
    }
    func prepareImageView() {
        imageView.backgroundColor = AppColors.barGreen
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.imageInfoLabel.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: view.frame.width),
            imageView.heightAnchor.constraint(equalToConstant: 400),
        ])
    }
    
    func prepareImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
    }
    
    func prepareToolBar() {
        toolBar.barTintColor = AppColors.barGreen
        NSLayoutConstraint.activate([
            toolBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            toolBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toolBar.widthAnchor.constraint(equalToConstant: view.frame.width),
            toolBar.heightAnchor.constraint(equalToConstant: 80),
        ])
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), cameraButton]
    }
    
    func prepareCameraButton() {
        cameraButton.tintColor = AppColors.textColor
        
    }
    
    func prepareContinueButton() {
        NSLayoutConstraint.activate([
            continueButton.widthAnchor.constraint(equalToConstant: 304),
            continueButton.heightAnchor.constraint(equalToConstant: 40),
            continueButton.topAnchor.constraint(equalTo: self.calculateButton.bottomAnchor, constant: 50),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        self.continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    func prepareCalculateButton() {
        NSLayoutConstraint.activate([
            calculateButton.widthAnchor.constraint(equalToConstant: 200),
            calculateButton.heightAnchor.constraint(equalToConstant: 40),
            calculateButton.topAnchor.constraint(equalTo: self.imageCalorieLabel.bottomAnchor, constant: 50),
            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        self.calculateButton.addTarget(self, action: #selector(calculateButtonTapped), for: .touchUpInside)
    }
    
    func prepareImageInfoLabel() {
        imageInfoLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        imageInfoLabel.textColor = AppColors.textColor
        NSLayoutConstraint.activate([
            imageInfoLabel.topAnchor.constraint(equalTo: self.toolBar.bottomAnchor, constant: 30),
            imageInfoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func prepareImageCalorieLabel() {
        imageCalorieLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        imageCalorieLabel.textColor = AppColors.textColor
        NSLayoutConstraint.activate([
            imageCalorieLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20),
            imageCalorieLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
    
    
}
