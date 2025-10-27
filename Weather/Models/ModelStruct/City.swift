//
//  File.swift
//  `a
//
//  Created by 1111 on 17.10.2025.
//

import Foundation
///Структура для описания города
struct City: Codable {
    
    ///Идентефикационный номер
    let id: Int
    
    ///Название города
    let name: String
    
    ///Координаты города
    let coord: Coord
    
    ///Страна в которой находится город
    let country: String
    
    ///Примерное количество населения
    let population: Int
}
