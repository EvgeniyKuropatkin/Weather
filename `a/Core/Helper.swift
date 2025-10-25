//
//  Helper.swift
//  `a
//
//  Created by 1111 on 16.10.2025.
//

import Foundation


///Открытая функция для форматирования даты в строку
func formatDate(_ dateString: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    
    if let date = inputFormatter.date(from: dateString) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd.MM.yyyy"
        return outputFormatter.string(from: date)
    }
    return "—"
}
///Открытая функция для преобразования кода погоды в соответствующую этому коду иконку
func mapIcon(_ code: String) -> String {
    switch code.prefix(2) {
    case "01": return "sun.max"
    case "02": return "cloud.sun"
    case "03", "04": return "cloud"
    case "09", "10": return "cloud.rain"
    case "11": return "bolt"
    case "13": return "snow"
    default: return "cloud"
    }
}
///Функция для изъятия из API данных для почасового прогноза
extension Welcome {
    var hourlyForecast: [HourlyForecastStruct] {
        list.prefix(8).map { item in
            let date = Date(timeIntervalSince1970: TimeInterval(item.dt))
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            let time = formatter.string(from: date)
            let temp = Int(item.main.temp)
            let icon = mapIcon(item.weather.first?.icon ?? "01d")
            return HourlyForecastStruct(time: time, temperature: "\(temp)°", icon: icon)
        }
    }
}
///Функция для изъятия из API данных для  прогноза на 7 дней
extension Welcome {
    var dailyForecast: [DailyForecastStruct] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: list) { item in
            calendar.startOfDay(for: Date(timeIntervalSince1970: TimeInterval(item.dt)))
        }
        let sortedDays = grouped.keys.sorted().prefix(7)
        return sortedDays.compactMap { day in
            guard let firstItem = grouped[day]?.first else { return nil }
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM"
            let dayStr = formatter.string(from: day)
            let temp = Int(firstItem.main.temp)
            let icon = mapIcon(firstItem.weather.first?.icon ?? "01d")
            return DailyForecastStruct(day: dayStr, temperature: "\(temp)°", icon: icon)
        }
    }
}


