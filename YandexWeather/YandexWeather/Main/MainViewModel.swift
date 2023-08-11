//
//  MainViewModel.swift
//  YandexWeather
//
//  Created by Руслан Шигапов on 10.08.2023.
//

import Foundation

protocol MainViewModelProtocol {
    func numberOfSections() -> Int
    func numberOfRows(in section: Section) -> Int
    func getWeatherList(completion: () -> Void)
}

final class MainViewModel: MainViewModelProtocol {
    
    private let citiesList = City.getCities()
    
    private var weatherList: [CityWeather] = []
    
    func numberOfSections() -> Int {
        Section.allCases.count
    }
    
    func numberOfRows(in section: Section) -> Int {
        var count = 1
        switch section {
        case .searchBar: break
            // temporary decision
        case .weatherList: count = citiesList.count
        case .infoButton: break
        }
        return count
    }
    
    func getWeatherList(completion: () -> Void) {
        citiesList.forEach { fetchWeather(in: $0) }
        completion()
    }
    
    private func fetchWeather(in city: City) {
        NetworkManager.shared.fetchWeather(
            for: city.latitude,
            and: city.longitude
        ) { [weak self] result in
            switch result {
            case .success(let cityWeather):
                self?.weatherList.append(cityWeather)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
