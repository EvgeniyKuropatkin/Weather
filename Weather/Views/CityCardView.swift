//
//  CityCardView.swift
//  `a
//
//  Created by 1111 on 13.09.2025.
//

import SwiftUI
///Структура предназначенная для показа карточки города на 1 экране, содержащая краткое описание погоды и дополнительную кнопку перехода к подробностям погоды в городе
struct CityCardView: View {
    
    ///создание карточки города
    let cityCard: CityCard
    
    ///переменная для удаления карточки города из cityCards
    let onDelete: () -> Void
    
    ///переменная для переключения на подробное описание погоды в избранном городе
    @State private var showDetails = false;
    
    var body: some View {
    // TODO: Сверни HStack и посмотри, что у тебя в ZStack. Если там один элемент, то он не нужен, то же касается и остальной верстки. Если ни на что не влияет и находится в структуре только один элемент, то это структура не нужна, лишнее вложение.
        ZStack {
            HStack{
                // TODO: alignment: .leading можно либо в VStack, либо в frame, верски в данном случае это не меняет
                VStack(alignment: .leading, spacing: 10){
                    
                    
                    // TODO: Если есть одинаковые модификаторы, то можно их объединить в group
                    Group{
                        Text(cityCard.name)
                        
                        Text(cityCard.temperature)
                        
                        Text(cityCard.ShortWeather)
                        
                        
                        Button(
                            action: {
                                showDetails.toggle()
                            }, label: {
                                Text("Подробнее")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        )
                    }
                    .foregroundColor(.blue)
                    .fontWeight(.heavy)
                    
                    //                    // TODO: Лучше sheet вешать на внешнюю структуру, чтобы видеть что у тебя на данной view
                    //                    .sheet(isPresented: $showDetails){
                    //                        ShowDetailsView(cityCard:cityCard)
                    //                    }
                }
                .frame(maxWidth: .infinity/*, alignment: .leading)*/)
                .padding()
                
                Image(cityCard.icon)
                    .scaledToFit()
                    .padding()
            }
            .overlay(alignment: .topTrailing){
                Button{
                    onDelete()
                }
                label:{
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(5)
                }
            }
            
            
        }
        .cornerRadius(10)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(RoundedRectangle(cornerRadius: 20)
            .stroke(.white.opacity(0.2), lineWidth: 1))
        .shadow(color: .black.opacity(0.1),
                radius: 10, x: 0, y: 4)
        
        .sheet(isPresented: $showDetails){
            ShowDetailsView(cityCard:cityCard)
        }
        
    }
}

#Preview {
    CityCardView(
        cityCard: CityCard(
            name: "Нью-Йорк",
            temperature: "15.0 °C",
            icon: "cloud.rain",
            ShortWeather: "Облачно",
            wind: "15 м/с",
            humidity: 40,
            date: "15.09.2025"
        ),
        onDelete: { }
    )
}
