//
//  TodayViewModel.swift
//  HealthyWeight
//
//  Created by Begum Unal on 6.06.2023.
//

import Foundation

protocol ITodayViewModel{
    var view: ITodayView? {get set}
    func viewDidLoad()
    func viewWillAppear()
    func addButtonTapped()
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
    }
    
    func viewWillAppear() {
        view?.fetchTableViewData()
    }
    
    func addButtonTapped() {
        view?.goToNextVC()
    }
    
    
}
