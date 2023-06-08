//
//  TodayViewController.swift
//  HealthyWeight
//
//  Created by Begum Unal on 3.05.2023.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase
import CoreML
import Vision

protocol ITodayView: AnyObject, SeguePerformable{
    func prepareView()
    func prepareTableView()
    func prepareToolBar()
    func prepareAddButton()
    func prepareImagePicker()
    func prepareLabel()
    func fetchTableViewData()
    func loadData()
    func makePresent()
    func printFoodName(foodName: String)
}

final class TodayViewController: UIViewController {
    lazy var viewModel = TodayViewModel()
    let networkService = NetworkService()
    var imagePicker = UIImagePickerController()
    var total = 0.0
    var foods: [FoodModel] = []
    var tableView = UITableView()
    var label = UILabel()
    private let toolBar = UIToolbar()
    private let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewWillAppear()
    }

    @objc func addButtonTapped(){
        viewModel.addButtonTapped()
    }
    func detect(image : UIImage){
        viewModel.detect(image: image)
    }
}
extension TodayViewController: ITodayView{

    func makePresent() {
        present(imagePicker, animated: true, completion: nil)
    }
    func printFoodName(foodName: String) {
        print("En yüksek olasılıklı sınıf: \(foodName)")
        UserInfoManager.shared.foodName = foodName
        self.networkService.getCalorie(query: UserInfoManager.shared.foodName!)
    }
    func fetchTableViewData() {
        self.foods = []
        self.loadData()
    }
    
    func prepareView() {
        view.backgroundColor = AppColors.mainColor
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toolBar)
        view.addSubview(tableView)
        view.addSubview(label)
    }
    func prepareImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
    }
    func prepareLabel() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.toolBar.bottomAnchor, constant: 0),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: view.frame.width),
            label.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = AppColors.mainColor
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 0),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.widthAnchor.constraint(equalToConstant: view.frame.width),
            tableView.heightAnchor.constraint(equalToConstant: view.frame.height),
        ])
    }
    
    func prepareToolBar() {
        toolBar.barTintColor = AppColors.barGreen
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), addButton]
        NSLayoutConstraint.activate([
            toolBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            toolBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toolBar.widthAnchor.constraint(equalToConstant: view.frame.width),
            toolBar.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    func prepareAddButton() {
        addButton.tintColor = AppColors.textColor
    }
    
    func loadData(){
        let ref = Database.database().reference().child(UserInfoManager.shared.userID!).child("foods").child(UtilityFunctions.getDate())
        ref.observeSingleEvent(of: .value) { snapshot in
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for child in children {
                guard let value = child.value as? [String: Any],
                      let image = value["image"] as? String,
                      let foodName = value["foodName"] as? String,
                      let foodCalorie = value["foodCalorie"] as? Double else {
                    continue
                }
                let food = FoodModel(image: image, foodName: foodName, foodCalorie: foodCalorie)
                self.foods.append(food)
            }
            self.tableView.reloadData()
        }
    }
}
extension TodayViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            /*guard let convertedCIImage = CIImage(image: userPickedImage)else {
             fatalError("connot convert to CIImage")
             }*/
            detect(image: userPickedImage)
            UserInfoManager.shared.foodImage = userPickedImage
            self.imagePicker.dismiss(animated: true,completion: nil)
            let nextVC = AddItemViewController()
            makePushVC(nextVC: nextVC)
        }
    }
}
