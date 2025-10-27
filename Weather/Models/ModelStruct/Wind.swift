//
//  Wind.swift
//  `a
//
//  Created by 1111 on 17.10.2025.
//

import Foundation

///Структура описывающая подробности о ветре
struct Wind: Codable {
    
    ///Скорость, направление и порывы ветра
    let speed, deg, gust: Double
}
