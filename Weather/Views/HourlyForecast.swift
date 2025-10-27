//
//  hourlyForcast.swift
//  `a
//
//  Created by 1111 on 21.09.2025.
//

import SwiftUI
///Структура для описания почасового прогноза погоды
import SwiftUI

struct HourlyForecast: View {
    
    ///Переменная для хранения извлеченных данных
    @State private var items: [HourlyForecastStruct] = []
    
    ///Переменная для обозначения загрузки
    @State private var isLoading = false
    
    ///Переменную берем извне
    let cityName: String

    var body: some View {
        Group {
            if isLoading {
                ProgressView("Загрузка...")
            } else if items.isEmpty {
                Text("Нет данных")
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(items, id: \.time) { item in
                            VStack(spacing: 6) {
                                
                                Text(item.time)
                                    .font(.caption)
                                
                                Image(item.icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 64, height: 64)
                                
                                Text(item.temperature)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                            }
                            .frame(width: 60)
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white.opacity(0.2), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
                }
            }
        }
        .onAppear {
            loadForecast()
        }
    }

    private func loadForecast() {
        guard !isLoading else { return }
        isLoading = true
        Task {
            do {
                let weather = try await NetworkManager.shared.getWeather(for: cityName)
                await MainActor.run {
                    self.items = weather.hourlyForecast
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    print("Ошибка загрузки: \(error)")
                    self.isLoading = false
                }
            }
        }
    }
}

#Preview {
    HourlyForecast(cityName: "Paris")
}
