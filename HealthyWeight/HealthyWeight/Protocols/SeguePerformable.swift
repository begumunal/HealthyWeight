//
//  Presentable.swift
//  HealthyWeight
//
//  Created by Begum Unal on 7.06.2023.
//

import Foundation
import UIKit

protocol SeguePerformable{
    func makePushVC(nextVC: UIViewController)
}
extension SeguePerformable where Self: UIViewController{
 
    func makePushVC(nextVC: UIViewController){
        nextVC.modalPresentationStyle = .fullScreen
        navigationItem.backButtonTitle = ""
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        UIView.transition(with: self.navigationController!.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.navigationController?.pushViewController(nextVC, animated: false)
        }, completion: nil)
    }
    
}
