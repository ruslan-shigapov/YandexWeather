//
//  City.swift
//  YandexWeather
//
//  Created by Руслан Шигапов on 10.08.2023.
//

struct City {
    let name: String
    let latitude: Double
    let longitude: Double
    
    static func getCities() -> [City] {
        [
            City(name: "Москва", latitude: 55.45, longitude: 37.37),
            City(name: "Санкт-Петербург", latitude: 59.57, longitude: 30.19),
            City(name: "Новосибирск", latitude: 55.01, longitude: 82.55),
            City(name: "Екатеринбург", latitude: 56.50, longitude: 60.35),
            City(name: "Казань", latitude: 55.47, longitude: 49.06),
            City(name: "Нижний Новгород", latitude: 56.19, longitude: 44.00),
            City(name: "Челябинск", latitude: 55.09, longitude: 61.24),
            City(name: "Омск", latitude: 54.58, longitude: 73.23),
            City(name: "Краснодар", latitude: 45.02, longitude: 38.59),
            City(name: "Ростов", latitude: 47.14, longitude: 39.42)
        ]
    }
}
