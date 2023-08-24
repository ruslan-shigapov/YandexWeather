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
    var filteredCities: [City] { get set }
    func numberOfSections() -> Int
    func numberOfRows(in section: Section) -> Int
    func getCityCellViewModel(at indexPath: IndexPath) -> CityCellViewModelProtocol
    func getDetailsViewModel(at indexPath: IndexPath) -> DetailsViewModelProtocol
    func search(by text: String, completion: () -> Void)
}

final class MainViewModel: MainViewModelProtocol {
    
    private let citiesList = City.getCities()
    
    var footerButtonWasPressed: (() -> Void)?
    
    lazy var filteredCities: [City] = {
        citiesList
    }()
    
    func numberOfSections() -> Int {
        Section.allCases.count
    }
    
    func numberOfRows(in section: Section) -> Int {
        section == .weatherList ? filteredCities.count : 1
    }
    
    func getCityCellViewModel(at indexPath: IndexPath) -> CityCellViewModelProtocol {
        CityCellViewModel(city: filteredCities[indexPath.row])
    }
    
    func getDetailsViewModel(at indexPath: IndexPath) -> DetailsViewModelProtocol {
        DetailsViewModel(city: filteredCities[indexPath.row])
    }
    
    func search(by text: String, completion: () -> Void) {
        filteredCities = text.isEmpty ? citiesList : citiesList.filter { city -> Bool in
            city.name.range(of: text, options: .caseInsensitive) != nil
        }
        completion()
    }
}
