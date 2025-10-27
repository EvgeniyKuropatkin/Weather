//
//  dailyForecast.swift
//  `a
//
//  Created by 1111 on 26.09.2025.
//

import SwiftUI
///Структура для описания прогноза погоды на 7 дней
struct DailyForecast: View {
    
    ///Переменная для хранения извлеченных данных
    @State private var items: [DailyForecastStruct] = []
    
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
                        ForEach(items, id: \.day) { item in
                            VStack(spacing: 6) {
                                
                                Text(item.day)
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
                    self.items = weather.dailyForecast
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    print("Ошибка: \(error)")
                    self.isLoading = false
                }
            }
        }
    }
}

#Preview {
    DailyForecast(cityName: "Paris")
}
