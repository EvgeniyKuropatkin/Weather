//
//  Clouds.swift
//  `a
//
//  Created by 1111 on 17.10.2025.
//

import Foundation

///Структура описания облачности
struct Clouds: Codable {
    
    ///Процент облачности в процентах
    let all: Int
}
///Структура основных метеорологических показателей
struct Main: Codable {
    ///Текущая температура в Кельвинах
    ///Минимальная и максимальная температура в Кельвинах за прошедший час
    ///Атмосферное давление в гПа
    let temp, tempMin, tempMax, pressure: Double
    
    ///Атмосферное давление на уровне моря
    ///Атмосферное давление на уровне земли
    let seaLevel, grndLevel: Double
    
    ///влажность в текущий момент времени
    let humidity: Int
    
    ///Темпетарутный коэффициент в Кельвинах (Дневная - ночная температура)
    let tempKf: Double
    
    /// Ключи декодирования JSON-ответа от OpenWeatherMap API.
    enum CodingKeys: String, CodingKey {
        
        /// Текущая температура.
        case temp
        
        /// Минимальная температура
        case tempMin = "temp_min"
        
        /// Максимальная температура
        case tempMax = "temp_max"
        
        /// Атмосферное давление.
        case pressure
        
        /// Давление на уровне моря
        case seaLevel = "sea_level"
        
        /// Давление на уровне земли
        case grndLevel = "grnd_level"
        
        /// Относительная влажность в процентах
        case humidity
        
        /// Температурный коэффициент - разница между днём и ночью
        case tempKf = "temp_kf"

    }
}
