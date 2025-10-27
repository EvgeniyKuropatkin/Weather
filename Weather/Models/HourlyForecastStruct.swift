//
//  hourlyForcaststruct.swift
//  `a
//
//  Created by 1111 on 24.09.2025.
//

import Foundation

/// Структура для почасового  прогноза
struct HourlyForecastStruct: Hashable{
    
    ///Время в дне для которого описываем погоду
    var time: String
    
    ///Темпертаура в это время
    var temperature: String
    
    ///Иконка для показания краткой погоды в это время
    var icon: String
}
