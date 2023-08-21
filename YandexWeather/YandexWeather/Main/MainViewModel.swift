//
//  MainViewModel.swift
//  YandexWeather
//
//  Created by Руслан Шигапов on 10.08.2023.
//

import Foundation

protocol InfoCellDelegate {
    var footerButtonWasPressed: (() -> Void)? { get set }
}

protocol MainViewModelProtocol: InfoCellDelegate {
    func numberOfSections() -> Int
    func numberOfRows(in section: Section) -> Int
    func fetchAllWeather(completion: @escaping () -> Void)
    func getCityName(at indexPath: IndexPath) -> String
    func getCityCellViewModel(at indexPath: IndexPath) -> CityCellViewModelProtocol
    func getDetailsViewModel(at indexPath: IndexPath) -> DetailsViewModelProtocol
}

final class MainViewModel: MainViewModelProtocol {
    
    private let citiesList = City.getCities()
    
    private var weatherList: [CityWeather] = []
    
    var footerButtonWasPressed: (() -> Void)?
    
    func numberOfSections() -> Int {
        Section.allCases.count
    }
    
    func numberOfRows(in section: Section) -> Int {
        var count: Int
        switch section {
        case .searchBar: count = 1
        case .weatherList:
            count = weatherList.count
        case .infoButton: count = 1
        }
        return count
    }
    
    func fetchAllWeather(completion: @escaping () -> Void) {
        for city in citiesList {
            NetworkManager.shared.fetchWeather(
                for: city.latitude,
                and: city.longitude
            ) { [weak self] result in
                switch result {
                case .success(let cityWeather):
                    DispatchQueue.global().async {
                        self?.weatherList.append(cityWeather)
                    }
                    completion()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getCityName(at indexPath: IndexPath) -> String {
        citiesList[indexPath.row].name
    }
    
    func getCityCellViewModel(at indexPath: IndexPath) -> CityCellViewModelProtocol {
        CityCellViewModel(cityWeather: weatherList[indexPath.row])
    }
    
    func getDetailsViewModel(at indexPath: IndexPath) -> DetailsViewModelProtocol {
        DetailsViewModel(city: citiesList[indexPath.row])
    }
}
