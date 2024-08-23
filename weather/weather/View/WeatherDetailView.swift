//
//  WeatherDetailView.swift
//  weather
//
//  Created by Денис Кононов on 20.08.2024.
//

import SwiftUI

struct WeatherDetailView: View {
    @StateObject private var viewModel = WeatherViewModel()
    var array: [WeatherModel] = Array(repeating: WeatherModel(), count: 5)
    
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(viewModel.currentWeatherForCitys){ item in
                    ContainerWeatherDetail(model: item)
                        .containerRelativeFrame(.horizontal, count: 1, spacing: 10)
                        .scrollTransition{ content,phase in
                            content
                                .opacity(phase.isIdentity ? 1 : 0)
                                .scaleEffect(x: phase.isIdentity ? 1 : 0.3)
                                .offset(y: phase.isIdentity ? 0 : 50)
                        }
                }
            }
            Spacer()
        }
        .contentMargins(20, for: .scrollContent)
        .scrollTargetBehavior(.paging)
    
    }
}

#Preview {
    WeatherDetailView()
}
