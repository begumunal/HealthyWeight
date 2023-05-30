//
//  HistoryViewController.swift
//  HealthyWeight
//
//  Created by Begum Unal on 3.05.2023.
//

import UIKit

class HistoryViewController: UIViewController {
    private let toolBar = UIToolbar()
    var tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.mainColor
        tableView.delegate = self
        tableView.dataSource = self
        setup()
    }
    private func setup(){
        toolBar.barTintColor = AppColors.barGreen
    
        self.toolBar.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(toolBar)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            self.toolBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            self.toolBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.toolBar.widthAnchor.constraint(equalToConstant: view.frame.width),
            self.toolBar.heightAnchor.constraint(equalToConstant: 80),
            
            self.tableView.topAnchor.constraint(equalTo: self.toolBar.bottomAnchor, constant: 0),
            self.tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.tableView.widthAnchor.constraint(equalToConstant: view.frame.width),
            self.tableView.heightAnchor.constraint(equalToConstant: view.frame.height),
            
            
        ])
    }

    

}
extension HistoryViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomTableViewHistoryCell(style: .default, reuseIdentifier: "CustomTableViewHistoryCell")
        
        return cell
    }
    
    
}
