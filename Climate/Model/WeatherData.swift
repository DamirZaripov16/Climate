//
//  WeatherData.swift
//  Climate
//
//  Created by Damir Zaripov on 03.05.2023.
//

import UIKit

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
}

