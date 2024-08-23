//
//  ContentView.swift
//  weather
//
//  Created by Денис Кононов on 16.08.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationStack {
        VStack {
            HStack{
                Text(viewModel.currentCity)
                    .font(.system(size: 48, weight: .bold))
                Spacer()
                NavigationLink{
                    WeatherDetailView()
                } label: {
                    Image("Category2")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.white)
                }
                .frame(width: 50, height: 50)
                .background(.purple)
                .clipShape(.circle)
            }
            .padding()
            
            ContainerWeather(model: viewModel.currentWeatherForCurrentCity)
            
            HStack{
                Text("Forecast for 5 day")
                    .font(.system(size: 20,weight: .bold))
                Spacer()
            }
            .padding(26)
            List(viewModel.forecastWeatherForCurrentCity){ weather in
                ContainerWeather(model:weather)
                    .listRowSeparator(.hidden)
                
            }
            .listStyle(.plain)
            .padding(.horizontal, -20)
            if viewModel.forecastWeatherForCurrentCity.isEmpty {
                Text("Loading...")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .onAppear {
            viewModel.loadWeather()
        }
    }
}
}

#Preview {
    ContentView()
}
