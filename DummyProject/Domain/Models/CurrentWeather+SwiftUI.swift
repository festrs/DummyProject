//
//  CurrentWeather+Stubbable.swift
//  DummyProject
//
//  Created by Felipe Dias Pereira on 29/09/20.
//  Copyright © 2020 FelipePereira. All rights reserved.
//

import Common

extension CurrentWeatherResponse.Main: Stubbable {
  static func stub(withID id: String) -> CurrentWeatherResponse.Main {
    CurrentWeatherResponse.Main(temperature: 15.1,
                                humidity: 80,
                                maxTemperature: 23.3,
                                minTemperature: 12.0)
  }
}

extension CurrentWeatherResponse.Coord: Stubbable {
  static func stub(withID id: String) -> CurrentWeatherResponse.Coord {
    CurrentWeatherResponse.Coord(lon: 10, lat: 10)
  }
}

extension CurrentWeatherResponse: Stubbable {
  static func stub(withID id: String) -> CurrentWeatherResponse {
    CurrentWeatherResponse(coord: .stub(withID: ""),
                           main: .stub(withID: ""),
                           name: id)
  }
}
