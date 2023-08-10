//
//  NetworkManager.swift
//  YandexWeather
//
//  Created by Руслан Шигапов on 10.08.2023.
//

import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let key = "94a2fd21-e55c-4326-8220-932ad2de2459"
    
    private let link = "https://api.weather.yandex.ru/v2/informers?"
    
    private var headers: HTTPHeaders {
        ["X-Yandex-API-Key": "\(key)"]
    }
    
    private init() {}
    
    func fetchWeather(from url: String,
                       completion: @escaping (Result<City, AFError>) -> Void) {
        // link + ...
        AF.request(url, headers: headers)
            .validate()
            .responseDecodable(of: City.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
