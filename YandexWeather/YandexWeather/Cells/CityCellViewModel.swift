//
//  CityCellViewModel.swift
//  YandexWeather
//
//  Created by Руслан Шигапов on 14.08.2023.
//

import Foundation

protocol CityCellViewModelProtocol {
    var condition: String { get }
    var icon: String { get }
    var temperature: String { get }
    var sunrise: String { get }
    var sunset: String { get }
    init(cityWeather: CityWeather)
}

final class CityCellViewModel: CityCellViewModelProtocol {
    
    var condition: String {
        cityWeather.fact.condition
    }
    
    var icon: String {
        cityWeather.fact.icon
    }
    
    var temperature: String {
        "\(cityWeather.fact.temp) \u{00B0}C"
    }
    
    var sunrise: String {
        "sunrise at \(cityWeather.forecast.sunrise)"
    }
    
    var sunset: String {
        "sunset at \(cityWeather.forecast.sunset)"
    }
    
    private let cityWeather: CityWeather
    
    required init(cityWeather: CityWeather) {
        self.cityWeather = cityWeather
    }
}

