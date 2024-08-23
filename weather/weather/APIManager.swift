//
//  APIManager.swift
//  weather
//
//  Created by Денис Кононов on 19.08.2024.
//

import Foundation
import SwiftUI

class APIManager {

    static let shared = APIManager()

    func fetchWeatherData(for citys:[String], days:String, completion: @escaping ([[WeatherModel]], [WeatherModel]) -> Void) {
        let apiKey = "aff3a9bdc09a4a578ab93645241908"
        var weatherModelsArray = [[WeatherModel]]()
        var currentWeatherArray = [WeatherModel]()
        let dispatchGroup = DispatchGroup()

        for city in citys {
            dispatchGroup.enter()
            
            lazy var URLComponent: URLComponents = {
                var component = URLComponents(string: "https://api.weatherapi.com")
                component?.path = "/v1/forecast.json"
                component?.queryItems = [
                    URLQueryItem(name: "key", value: apiKey),
                    URLQueryItem(name: "q", value: city),
                    URLQueryItem(name: "days", value: days)
                ]
                return component ?? URLComponents()
            }()
            guard let url = URLComponent.url else {
                dispatchGroup.leave()
                continue
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    dispatchGroup.leave()
                    return
                }

                guard let data = data else {
                    print("No data received")
                    dispatchGroup.leave()
                    return
                }

                if let decodedResponse = try? JSONDecoder().decode(Weather.self, from: data) {
                    var weatherModels = [WeatherModel]()
                    let location = decodedResponse.location

                    let iconDispatchGroup = DispatchGroup()

                    for forecast in decodedResponse.forecast.forecastday {
                        iconDispatchGroup.enter()
                        self.loadWeatherIcon(from: forecast.day.condition.icon) { image in
                            let weatherModel = WeatherModel(
                                dayOfTheWeek: forecast.date.toDayOfWeek() ?? "",
                                weatherType: forecast.day.condition.text,
                                temperature: "\(Int(forecast.day.avgtempC))",
                                city: location.name,
                                weatherIcon: image
                            )
                            weatherModels.append(weatherModel)
                            iconDispatchGroup.leave()
                        }
                    }

                    iconDispatchGroup.notify(queue: .main) {
                        if !weatherModels.isEmpty {
                            weatherModels.removeFirst()
                        }
                        weatherModelsArray.append(weatherModels)

                        let currentWeather = decodedResponse.current
                        self.loadWeatherIcon(from: currentWeather.condition.icon) { image in
                            let today = WeatherModel(
                                dayOfTheWeek: "Today",
                                weatherType: currentWeather.condition.text,
                                temperature: "\(Int(currentWeather.tempC))",
                                city: location.name,
                                weatherIcon: image
                            )
                            currentWeatherArray.append(today)
                            print("Added current weather for \(city): \(today)")
                            dispatchGroup.leave()
                        }
                    }
                } else {
                    print("Failed to decode JSON for city \(city).")
                    dispatchGroup.leave()
                }
            }.resume()
        }

        dispatchGroup.notify(queue: .main) {
            completion(weatherModelsArray, currentWeatherArray)
        }
    }

    private func loadWeatherIcon(from url: String,  completion: @escaping(UIImage) -> Void) {
        let fullURL = "https:" + url
        guard let iconURL = URL(string: fullURL) else { return }
        URLSession.shared.dataTask(with: iconURL) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                completion(UIImage(systemName: "sun.max.fill")!)
                return
            }
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
