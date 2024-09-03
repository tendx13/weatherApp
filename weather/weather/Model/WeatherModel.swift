//
//  WeatherModel.swift
//  weather
//
//  Created by Денис Кононов on 17.08.2024.
//

import Foundation
import SwiftUI

class WeatherModel: ObservableObject, Identifiable {
    @Published var dayOfTheWeek: String = "Today"
    @Published var weatherType: String = "Sunny"
    @Published var temperature: String = "20"
    @Published var city:String = "Astana"
    @Published var weatherIcon: UIImage? = UIImage(systemName: "sun.max.fill")
    var id = UUID()

    init(dayOfTheWeek: String = "Today", weatherType: String = "Sunny", temperature: String = "20", city:String = "Astana", weatherIcon: UIImage = UIImage(systemName: "sun.max.fill")! ) {
        self.dayOfTheWeek = dayOfTheWeek
        self.weatherType = weatherType
        self.temperature = temperature
        self.city = city
        self.weatherIcon = weatherIcon
    }

}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weather = try? JSONDecoder().decode(Weather.self, from: jsonData)

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}

// MARK: - Current
struct Current: Codable {
    let tempC: Double
    let condition: Condition
    let windMph: Double
    let windDir: String
    let pressureIn: Double
    let humidity: Int
    let feelslikeC: Double

    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition
        case windMph = "wind_mph"
        case windDir = "wind_dir"
        case pressureIn = "pressure_in"
        case humidity
        case feelslikeC = "feelslike_c"
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text, icon: String
}

// MARK: - Forecast
struct Forecast: Codable {
    let forecastday: [Forecastday]
}

// MARK: - Forecastday
struct Forecastday: Codable {
    let date: String
    let dateEpoch: Int
    let day: Day

    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day
    }
}

// MARK: - Day
struct Day: Codable {
    let avgtempC: Double
    let condition: Condition

    enum CodingKeys: String, CodingKey {
        case avgtempC = "avgtemp_c"
        case condition
    }
}

// MARK: - Location
struct Location: Codable {
    let name, region, country: String
    let lat, lon: Double
    let tzID: String
    let localtimeEpoch: Int
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}
