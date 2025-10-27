//
//  APIEnums.swift
//  `a
//
//  Created by 1111 on 16.10.2025.
//

import Foundation
///Enums для хранения ошибок при работе с API
enum NetworkError: String, Error{
    
    /// Неверный URL
    case invalidURL = "InvalidURL"
    
    ///Невалидные данные
    case invalidResponse = "InvalidResponse"
    
    ///Невалидные данные
    case invadidData = "InvalidData"
}
