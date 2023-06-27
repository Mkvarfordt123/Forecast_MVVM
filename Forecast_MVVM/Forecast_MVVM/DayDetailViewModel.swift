//
//  DayDetailViewModel.swift
//  Forecast_MVVM
//
//  Created by Milo Kvarfordt on 6/27/23.
//

import Foundation
protocol DayDetailViewDelegate: AnyObject {
    func updateViews()
}

class DayDetailViewModel {
    
    var forecastData: TopLevelDictionary?
    
    //Step 3
    var days: [Day] { //SOT
        self.forecastData?.days ?? []
    }
    
    weak var delegate: DayDetailViewDelegate?
    
    private let networkingController: NetworkingContoller
    
    private func fetchForecastData() {
        NetworkingContoller.fetchDays { [weak self] result in
            switch result {
            case .success(let forecastData):
                self?.forecastData = forecastData
                self?.delegate?.updateViews()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    init(delegate: DayDetailViewDelegate?, networkingController: NetworkingContoller = NetworkingContoller()) {
        self.delegate = delegate
        self.networkingController = networkingController
    
        fetchForecastData()
    }
}

