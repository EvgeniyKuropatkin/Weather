//
//  dailyForecastStruct.swift
//  `a
//
//  Created by 1111 on 26.09.2025.
//

import Foundation

/// Структура для прогноза на 7 дней
struct DailyForecastStruct: Hashable{
    
    ///Дата дня для которого описываем погоду
    var day: String
    
    ///Температура в этом дне
    var temperature: String
    
    ///Иконка краткого описания погоды в этом дне
    var icon: String
}
