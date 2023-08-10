//
//  MainViewModel.swift
//  YandexWeather
//
//  Created by Руслан Шигапов on 10.08.2023.
//

import Foundation

enum Section: String, CaseIterable {
    case searchBar
    case citiesList
}

protocol MainViewModelProtocol {
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
}

final class MainViewModel: MainViewModelProtocol {
    
    private let citiesList: [City] = []
    
    func numberOfSections() -> Int {
        Section.allCases.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        let count: Int?
        
        let section = Section.allCases[section]
        switch section {
        case .searchBar: count = 1
        case .citiesList: count = citiesList.count
        }
        
        return count ?? 0
    }
}
