//
//  NetworkManager.swift
//  `a
//
//  Created by 1111 on 30.09.2025.
//

import Foundation
/// `NetworkManager` реализован как синглтон и предоставляет методы для получения данных о погоде.
final class NetworkManager {
    ///Общедоступный экземпляр `NetworkManager`
    static let shared = NetworkManager()
    ///Ключ к используемой API
    ///
    private let apiKey = "d5f8af7831dbd10890d036582b0d6628"
    ///Декодер JSON
    let decoder = JSONDecoder()
    
    /// Приватный инициализатор, предотвращающий создание дополнительных экземпляров.
    private init() {
        decoder.dateDecodingStrategy = .iso8601
    }
    
    ///Фнкция получения информации о погоде в искомом городе
    func getWeather(for SearchCity:String) async throws -> Welcome{
        let urlWeather = "https://api.openweathermap.org/data/2.5/forecast?q=\(SearchCity)&appid=\(apiKey)&units=metric&lang=ru"
        
        guard let url = URL(string: urlWeather) else {throw NetworkError.invalidURL}
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {throw NetworkError.invalidResponse}
        
        do{
            return try decoder.decode(Welcome.self, from: data)
        }
        catch{
            throw NetworkError.invadidData
        }
    }
}


