//
//  CityCard.swift
//  `a
//
//  Created by 1111 on 13.09.2025.
//

import Foundation
///Структура карточки города
struct CityCard: Hashable, Identifiable {
    
    ///Идентефикационный номер
    let id = UUID()
    
    /// Название города
    var name: String
    
    ///Температура города в текущий момент
    var temperature: String
    
    ///Иконка покоды в текущий момент
    var icon: String
    
    ///Кратное описание погоды в текущий момент
    var ShortWeather: String
    
    ///Скорость ветра в текущий момент
    var wind: String
    
    ///Влажность в текущий момент
    var humidity: Int
    
    ///Дата
    var date: String
}

