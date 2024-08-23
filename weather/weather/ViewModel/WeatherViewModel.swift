//
//  WeatherViewModel.swift
//  weather
//
//  Created by Денис Кононов on 17.08.2024.
//

import Foundation

class WeatherViewModel: ObservableObject {

    @Published var forecastWeatherForCurrentCity: [WeatherModel] = []
    @Published var todayWeather: WeatherModel = WeatherModel()
    @Published var currentCity: String = "Astana"
    @Published var citysArray: [String] = ["Astana", "Almaty", "Aqtau", "Karaganda", "Aktobe", "Atyrau", "Kostanay"]
    @Published var currentWeatherForCitys: [WeatherModel] = []
    @Published var weatherModelArray: [[WeatherModel]] = []
    @Published var currentWeatherForCurrentCity: WeatherModel = WeatherModel()
    @Published var filteredWeatherModelsForCurrentCity: [WeatherModel] = []

    init() {
        loadWeather()
    }
    
    func loadWeather() {
        APIManager.shared.fetchWeatherData(for: citysArray, days: "6") { [weak self] weatherModelArray, todayWeatherArray in
            guard let self = self else { return }
            
            self.weatherModelArray = weatherModelArray
            self.currentWeatherForCitys = todayWeatherArray
            print(currentWeatherForCitys)
            
            // Поиск текущей погоды для текущего города
            if let matchingWeatherModel = self.currentWeatherForCitys.first(where: { $0.city == self.currentCity }) {
                self.currentWeatherForCurrentCity = matchingWeatherModel
                print("Current weather for \(self.currentCity): \(matchingWeatherModel)")
            } else {
                print("No matching weather model found for \(self.currentCity) in currentWeatherForCitys")
            }
            
            // Фильтрация массива массивов для текущего города
            if let matchingWeatherArray = self.weatherModelArray.first(where: { weatherArray in
                weatherArray.contains(where: { $0.city == self.currentCity })
            }) {
                self.filteredWeatherModelsForCurrentCity = matchingWeatherArray
                self.forecastWeatherForCurrentCity = self.filteredWeatherModelsForCurrentCity
                print("Filtered weather models for \(self.currentCity): \(matchingWeatherArray)")
            } else {
                print("No matching weather models found for \(self.currentCity) in weatherModelArray")
            }
        }
    }
}
