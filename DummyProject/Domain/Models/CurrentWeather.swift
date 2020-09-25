//
//  CurrentWeather.swift
//  DummyProject
//
//  Created by Felipe Dias Pereira on 24/09/20.
//  Copyright © 2020 FelipePereira. All rights reserved.
//

import Foundation

struct CurrentWeatherResponse: Decodable, Identifiable {
  var id: String {
    return name
  }

  let coord: Coord
  let main: Main
  let name: String

  struct Main: Codable {
    let temperature: Double
    let humidity: Int
    let maxTemperature: Double
    let minTemperature: Double

    enum CodingKeys: String, CodingKey {
      case temperature = "temp"
      case humidity
      case maxTemperature = "temp_max"
      case minTemperature = "temp_min"
    }
  }

  struct Coord: Codable {
    let lon: Double
    let lat: Double
  }
}
