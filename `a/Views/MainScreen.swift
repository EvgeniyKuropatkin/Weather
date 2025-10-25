//
//  ContentView.swift
//  `a
//
//  Created by 1111 on 04.09.2025.
//

// ContentView.swift
import SwiftUI
///Структура предназначенная для показа первого экрана, содержащего 2 города искомых по умолчанию и поле поиска нового города
struct MainScreen: View {
    
    ///Переменная для нахождения первого и второго города по умолчанияю
    let firstSearch = "Москва"
    let secondSearch = "Ростов-на-Дону"
    
    ///Переменная предназначенная для поиска нового города
    @State private var SearchCity = ""
    
    ///Список городов которые отображаются на экране
    @State private var cityCards: [CityCard] = []
    
    ///Переменная для выдачи ошибки, о ненахождении искомого города
    @State private var errorMessage: String?
    
    ///добавляем переменную, удовлетворяющую требованиям записи
    private let storage : StorageManagerProtocol = StorageManager()
    
    var body: some View {
            VStack {
                TextField("Поиск", text: $SearchCity, onCommit: {
                    let trimmed = SearchCity.trimmingCharacters(in: .whitespacesAndNewlines)
                    if !trimmed.isEmpty {
                        addCity(named: trimmed)
                        SearchCity = ""
                    }
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onAppear {
                    loadInitialCities()
                }
                
                ScrollView {
                    ForEach(cityCards) { card in
                        CityCardView(cityCard: card) {
                            cityCards.removeAll { $0.id == card.id }
                            saveCurrentCities()
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .background(Image("backgroundForApp"))
            .alert("Ошибка", isPresented: .init(get: { errorMessage != nil }, set: { _ in errorMessage = nil })) {
                Button("OK") { errorMessage = nil }
            } message: {
                Text(errorMessage ?? "Неизвестная ошибка")
            }
        }
        
        private func loadInitialCities() {
            // Попытка загрузить сохранённые города
            if let savedCities = storage.stringArray(forKey: .SavedCities) {
                // Загружаем погоду для каждого
                for city in savedCities {
                    addCitySilently(named: city)
                }
            } else {
                // Если нет сохранённых — грузим дефолтные
                addCitySilently(named: firstSearch)
                addCitySilently(named: secondSearch)
            }
        }
        
        private func addCitySilently(named cityName: String) {
            Task {
                do {
                    let forecastResponse = try await NetworkManager.shared.getWeather(for: cityName)
                    guard let firstItem = forecastResponse.list.first else { return }
                    
                    let newCard = CityCard(
                        name: forecastResponse.city.name,
                        temperature: String(format: "%.0f°C", firstItem.main.temp),
                        icon: mapIcon(firstItem.weather.first?.icon ?? "01d"),
                        ShortWeather: firstItem.weather.first?.description ?? "Погода",
                        wind: String(format: "%.0f м/с", firstItem.wind.speed),
                        humidity: Int(firstItem.main.humidity),
                        date: formatDate(firstItem.dtTxt)
                    )
                    await MainActor.run {
                        if !cityCards.contains(where: { $0.name == newCard.name }) {
                            cityCards.append(newCard)
                        }
                    }
                } catch {
                    // При старте ошибки не показываем
                }
            }
        }

        private func addCity(named cityName: String) {
            Task {
                do {
                    let forecastResponse = try await NetworkManager.shared.getWeather(for: cityName)
                    guard let firstItem = forecastResponse.list.first else { return }
                    
                    let newCard = CityCard(
                        name: forecastResponse.city.name,
                        temperature: String(format: "%.0f°C", firstItem.main.temp),
                        icon: mapIcon(firstItem.weather.first?.icon ?? "01d"),
                        ShortWeather: firstItem.weather.first?.description ?? "Погода",
                        wind: String(format: "%.0f м/с", firstItem.wind.speed),
                        humidity: Int(firstItem.main.humidity),
                        date: formatDate(firstItem.dtTxt)
                    )
                    await MainActor.run {
                        if !cityCards.contains(where: { $0.name == newCard.name }) {
                            cityCards.append(newCard)
                            saveCurrentCities()
                        }
                    }
                } catch {
                    await MainActor.run {
                        errorMessage = "Город не найден"
                    }
                }
            }
        }
        
        private func saveCurrentCities() {
            let cityNames = cityCards.map { $0.name }
            storage.set(cityNames, forKey: .SavedCities)
        }
}
#Preview {
    MainScreen()
}
