//
//  CustomTabBar.swift
//  HealthyWeight
//
//  Created by Begum Unal on 30.05.2023.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomTabBar()
        setupViewControllers()
    }
    
    private func setupCustomTabBar() {
        let customTabBar = CustomTabBar()
        self.setValue(customTabBar, forKey: "tabBar")
    }
    
    private func setupViewControllers() {
        //let vc1 = HistoryViewController()
        let vc2 = TodayViewController()
        let vc3 = ProfileViewController()

       // vc1.tabBarItem = UITabBarItem(title: Constants.historyVCTitle, image: UIImage(systemName: "timer"), tag: 0)
        
        vc2.tabBarItem = UITabBarItem(title: Constants.todayVCTitle, image: UIImage(systemName: "calendar.badge.plus"), tag: 1)
        
        vc3.tabBarItem = UITabBarItem(title: Constants.profileVCTitle, image: UIImage(systemName: "person"), tag: 2)
       
        self.modalPresentationStyle = .fullScreen
        
        let viewControllers = [vc2, vc3]
        self.setViewControllers(viewControllers, animated: false)
    }
}
