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
}

final class MainViewModel: MainViewModelProtocol {
    
    private let citiesList: [City] = []
    
    func numberOfSections() -> Int {
        Section.allCases.count
    }
    
    func numberOfRows(in section: Section) -> Int {
        let count: Int?
        switch section {
        case .searchBar: count = 1
        case .citiesList: count = citiesList.count
        }
        return count ?? 0
    }
}
