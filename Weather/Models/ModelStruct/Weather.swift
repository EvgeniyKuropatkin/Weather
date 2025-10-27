//
//  Weather.swift
//  `a
//
//  Created by 1111 on 17.10.2025.
//

import Foundation

///Структура описания погодных условий
struct Weather: Codable {
    
    ///Идентификатор погодного состояния
    let id: Int
    
    ///Погодные условия, описание погоды, код иконки для описания погодных условий
    let main, description, icon: String
}
