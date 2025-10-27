//
//  List.swift
//  `a
//
//  Created by 1111 on 17.10.2025.
//

import Foundation

///Структура списка прогнозов погоды, упорядоченных по времени.
struct List: Codable {
    
    ///Дата и время
    let dt: Int
    
    ///Информация об основных метеорологических показателей
    let main: Main
    
    ///Информация о погоде
    let weather: [Weather]
    
    ///Информация об облачности
    let clouds: Clouds
    
    ///Информация о ветре
    let wind: Wind
    
    ///Информация о части суток
    let sys: Sys
    
    ///Дата и время
    let dtTxt: String
    
    ///Информация о б осадках
    let rain: Rain?
    
    /// Ключи декодирования JSON-ответа от OpenWeatherMap API.
    enum CodingKeys: String, CodingKey {
        
        /// Временная метка данных в формате Unix
        case dt
        
        /// Основные метеорологические данные
        case main
        
        /// Массив описаний погодных условий
        case weather
        
        /// Информация об облачности
        case clouds
        
        /// Данные о ветре
        case wind
        
        /// Часть суток
        case sys
        
        /// Время прогноза в читаемом формате
        case dtTxt = "dt_txt"
        
        /// Информация об осадках
        case rain
    }
}
