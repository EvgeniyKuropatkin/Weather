//
//  Model.swift
//  `a
//
//  Created by 1111 on 30.09.2025.
//
import Foundation
///Эта структура декодируется из JSON-ответа погодного API
struct Welcome: Codable {
    
    ///Код статуса ответа.
    let cod: String
    
    ///Дополнительное сообщение от сервера.
    let message: Double
    
    ///Количество элементов прогноза в массиве `list`
    let cnt: Int
    
    ///Список прогнозов погоды, упорядоченных по времени.
    let list: [List]
    
    ///Информация о городе, для которого запрошен прогноз.
    let city: City
}
