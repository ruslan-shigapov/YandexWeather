//
//  City.swift
//  YandexWeather
//
//  Created by Руслан Шигапов on 10.08.2023.
//

struct CityWeather: Codable {
    let fact: Fact
    let forecast: Forecast
}

struct Fact: Codable {
    let temp: Int
    let icon: String
    let condition: String
}

struct Forecast: Codable {
    let sunrise: String
    let sunset: String
}
