//
//  ContainerWeather.swift
//  weather
//
//  Created by Денис Кононов on 16.08.2024.
//

import SwiftUI

struct ContainerWeather: View {
    @ObservedObject var model: WeatherModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(model.dayOfTheWeek)
                    .font(.system(size: 28, weight: .medium))
                    .foregroundStyle(.white)
                    .padding(16)
                    .padding(.bottom, 42)
                
                Text(model.weatherType)
                    .font(.system(size: 18))
                    .foregroundStyle(.white)
                    .padding()
            }
            .padding(8)
            Spacer()
            VStack(alignment: .trailing) {
                if let icon = model.weatherIcon{
                    Image(uiImage: icon)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding(16)
                        .padding(.bottom, 16)
                }
                Text("\(model.temperature)℃")
                    .font(.system(size: 18))
                    .foregroundStyle(.white)
                    .padding(16)
                    .padding(.trailing, 16)
            }
            .padding(8)
        }
        .background(.purple)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding()
    }
}

#Preview {
    ContainerWeather(model: WeatherModel())
}
