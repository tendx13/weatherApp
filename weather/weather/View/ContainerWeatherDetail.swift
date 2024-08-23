//
//  ContainerWeatherDetail.swift
//  weather
//
//  Created by Денис Кононов on 20.08.2024.
//

import SwiftUI

struct ContainerWeatherDetail: View {
    @ObservedObject var model: WeatherModel
    
    var body: some View {
        VStack{
            if let icon = model.weatherIcon{
                Image(uiImage: icon)
                    .resizable()
                    .frame(width: 120, height: 120)
                    .padding(16)
                    .padding(.bottom, 16)
                    .padding(.leading, 50)
                    .padding(.trailing, 50)
            }
            Text(model.city)
                .font(.system(size: 18))
                .foregroundStyle(.white)
            
            Text("\(model.temperature)℃")
                .font(.system(size: 40, weight: .bold))
                .foregroundStyle(.white)
                .padding()
                .padding(.bottom,16)
            
            Text(model.weatherType)
                .font(.system(size: 18,weight: .bold))
                .foregroundStyle(.white)
                .padding(.bottom, 16)
        }
        .background(.purple)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

#Preview {
    ContainerWeatherDetail(model: WeatherModel())
}
