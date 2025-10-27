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
        ZStack {
            HStack{
                VStack(alignment: .leading, spacing: 10){
                    
                    Text(cityCard.name)
                        .foregroundColor(.blue)
                        .fontWeight(.heavy)
                    
                    Text(cityCard.temperature)
                        .foregroundColor(.blue)
                        .fontWeight(.heavy)
                    
                    Text(cityCard.ShortWeather)
                        .foregroundColor(.blue)
                        .fontWeight(.heavy)

                    Button(
                        action: {
                            showDetails.toggle()
                        }, label: {
                            Text("Подробнее")
                                .fontWeight(.heavy)
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    )
                    .sheet(isPresented: $showDetails){
                        ShowDetailsView(cityCard:cityCard)
                    }                }
                .frame(maxWidth: .infinity, alignment: .leading)
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
