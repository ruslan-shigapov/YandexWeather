//
//  DetailsViewModel.swift
//  YandexWeather
//
//  Created by Руслан Шигапов on 18.08.2023.
//

import Foundation

protocol DetailsViewModelProtocol {
    var cityName: String { get }
    var condition: String { get }
    var temperature: String { get }
    var icon: String { get }
    var feelsLike: String { get }
    var firstPartName: String { get }
    var firstPartCondition: String { get }
    var firstPartTemp: String { get }
    var secondPartName: String { get }
    var secondPartCondition: String { get }
    var secondPartTemp: String { get }
    init(city: City)
    func fetchWeather(completion: @escaping () -> Void)
}

final class DetailsViewModel: DetailsViewModelProtocol {
    
    var cityName: String {
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
    
    var feelsLike: String {
        "feels like \(cityWeather?.fact.feels_like ?? 0) \u{00B0}C"
    }
    
    var firstPartName: String {
        "forecast for \(cityWeather?.forecast.parts[0].part_name ?? "")"
    }
    
    var firstPartCondition: String {
        cityWeather?.forecast.parts[0].condition ?? ""
    }
    
    var firstPartTemp: String {
        "average temp: \(cityWeather?.forecast.parts[0].temp_avg ?? 0) \u{00B0}C"
    }
    
    var secondPartName: String {
        "forecast for \(cityWeather?.forecast.parts[1].part_name ?? "")"
    }
    
    var secondPartCondition: String {
        cityWeather?.forecast.parts[1].condition ?? ""
    }
    
    var secondPartTemp: String {
        "average temp: \(cityWeather?.forecast.parts[1].temp_avg ?? 0) \u{00B0}C"
    }
    
    private let city: City
    private var cityWeather: CityWeather?
    
    required init(city: City) {
        self.city = city
    }
    
    func fetchWeather(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchWeather(
            for: city.latitude,
            and: city.longitude
        ) { [weak self] result in
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
