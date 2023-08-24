//
//  CityCellViewModel.swift
//  YandexWeather
//
//  Created by Руслан Шигапов on 14.08.2023.
//

import Foundation

protocol CityCellViewModelProtocol {
    var name: String { get }
    var condition: String { get }
    var icon: String { get }
    var temperature: String { get }
    var sunrise: String { get }
    var sunset: String { get }
    init(city: City)
    func fetchWeather(completion: @escaping () -> Void)
}

final class CityCellViewModel: CityCellViewModelProtocol {
    
    var name: String {
        city.name
    }
    
    var condition: String {
        cityWeather?.fact.condition ?? ""
    }
    
    var icon: String {
        cityWeather?.fact.icon ?? ""
    }
    
    var temperature: String {
        "\(cityWeather?.fact.temp ?? 0) \u{00B0}C"
    }
    
    var sunrise: String {
        "sunrise at \(cityWeather?.forecast.sunrise ?? "")"
    }
    
    var sunset: String {
        "sunset at \(cityWeather?.forecast.sunset ?? "")"
    }
    
    private let city: City
    private var cityWeather: CityWeather?
    
    required init(city: City) {
        self.city = city
    }
    
    func fetchWeather(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchWeather(for: city) { [weak self] result in
            switch result {
            case .success(let cityWeather):
                self?.cityWeather = cityWeather
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

