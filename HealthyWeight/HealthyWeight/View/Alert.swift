//
//  Alert.swift
//  HealthyWeight
//
//  Created by Begum Unal on 2.05.2023.
//

import Foundation
import UIKit

public class AlertView{
    static func makeAlert(title: String, message : String, viewC : UIViewController){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        
        viewC.present(alertController, animated: true, completion: nil)
    }
    
    
    static func makeAlertForErrors( message : String) -> UIView{
        let alertView = UIView(frame: CGRect(x: 60, y: 100, width: 300, height: 50))
        
        alertView.backgroundColor = .red
        
        // Alert mesajı içeriği için bir UILabel
        let alertLabel = UILabel()
        alertLabel.text = message
        alertLabel.textColor = UIColor.white
        alertLabel.textAlignment = .center
        alertView.layer.cornerRadius = 20
        
        let iconImageView = UIImageView(image: UIImage(systemName: "xmark.circle"))
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = UIColor.white
        
        alertView.addSubview(alertLabel)
        alertView.addSubview(iconImageView)
        
        // Uyarı mesajının belirli bir süre sonra kaybolması
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            alertView.removeFromSuperview()
        }
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        alertLabel.topAnchor.constraint(equalTo: alertView.topAnchor).isActive = true
        alertLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor).isActive = true
        alertLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor).isActive = true
        alertLabel.bottomAnchor.constraint(equalTo: alertView.bottomAnchor).isActive = true
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.centerYAnchor.constraint(equalTo: alertView.centerYAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        return alertView
    }
    
    
}
