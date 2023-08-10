//
//  NetworkManager.swift
//  YandexWeather
//
//  Created by Руслан Шигапов on 10.08.2023.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let key = "94a2fd21-e55c-4326-8220-932ad2de2459"
    
    private let link = "https://api.weather.yandex.ru/v2/informers"
    
    private var headers: HTTPHeaders {
        ["X-Yandex-API-Key": "\(key)"]
    }
    
    private init() {}
    
    func fetchWeather(for latitude: Double,
                      and longitude: Double,
                      completion: @escaping (Result<CityWeather, AFError>) -> Void) {
        guard var urlComponents = URLComponents(string: link) else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: "\(latitude)"),
            URLQueryItem(name: "lon", value: "\(longitude)"),
        ]
        guard let url = urlComponents.url else { return }
        AF.request(url, headers: headers)
            .validate()
            .responseDecodable(of: CityWeather.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
