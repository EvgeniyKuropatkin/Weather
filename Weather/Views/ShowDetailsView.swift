//
//  showDetailsView.swift
//  `a
//
//  Created by 1111 on 16.09.2025.
//

import SwiftUI
///Структура для показа детального прогноза погоды в выбранном городе
struct ShowDetailsView: View {
    
    ///переменная принимающая данные
    let cityCard: CityCard
    
    ///Переменная для работы переключения между почасовым прогнозом погоды и прогнозом погоды на 7 дней
    @State private var whichForecast: Bool = false
    
    ///Переменная для закрытия подробностей прогноза погоды через кнопку
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            
            Text(cityCard.name)
                .font(.largeTitle)
                .padding()
                .frame(maxWidth: .infinity)
            
            Text("\(cityCard.date)")
                .padding()
            
            Text("\(cityCard.temperature)")
                .font(.title)
            
            Image(cityCard.icon)
                .resizable()
                .frame(width: 170, height: 150)
            
            Text("\(cityCard.ShortWeather)")
                .frame(maxWidth: 300)
                .lineLimit(nil)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding()
            
            HStack{
                Image("wind")
                    .resizable()
                    .frame(width: 30, height: 30)
                
                Text("\(cityCard.wind)")
                    .padding(.trailing, 20.0)
                
                Image("humidity")
                    .resizable()
                    .frame(width: 30, height: 30)
                
                Text("\(cityCard.humidity)"+"%")
            }
            
            Picker("Тип прогноза", selection: $whichForecast) {
                Text("Прогноз на каждые 3 часа")
                    .tag(false)
                
                Text("Прогноз на 7 дней")
                    .tag(true)
            }
            .pickerStyle(.segmented)
            .padding(20.0)
            
            if whichForecast {
                DailyForecast(cityName: cityCard.name)
                    .padding(10.0)
            } else {
                HourlyForecast(cityName: cityCard.name)
                    .padding(10.0)
            }
        }
        .overlay(alignment: .topTrailing){
            Button(
                action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label:{
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray .opacity(0.5))
                        .padding(5)
                }
            )
        }
        .frame(maxWidth: .infinity, alignment: .topTrailing)
        .background(Image("backgroundForApp"))
    }
}

#Preview {
    ShowDetailsView(
        cityCard: CityCard(name: "Нью-Йорк",
                temperature: "15.0"+" °C",
                icon: "cloud.rain",
                ShortWeather: "Дождь",
                wind: "6 м/с",
                humidity: 40,
                date: "15.09.2025" ))
}
