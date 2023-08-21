//
//  InfoViewModel.swift
//  YandexWeather
//
//  Created by Руслан Шигапов on 21.08.2023.
//

import Foundation

protocol InfoViewModelProtocol {
    var request: URLRequest? { get }
}

final class InfoViewModel: InfoViewModelProtocol {
    
    var request: URLRequest? {
        guard let url = URL(string: "https://yandex.ru/pogoda/") else {
            return nil
        }
        return URLRequest(url: url)
    }
}
