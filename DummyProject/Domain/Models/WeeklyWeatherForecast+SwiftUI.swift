//
//  WeeklyWeatherForecast+Stubbable.swift
//  DummyProject
//
//  Created by Felipe Dias Pereira on 29/09/20.
//  Copyright © 2020 FelipePereira. All rights reserved.
//

import Foundation
import Common

extension WeeklyForecastResponse: Stubbable {
  static func stub(withID id: String) -> WeeklyForecastResponse {
    WeeklyForecastResponse(list: .stub(withCount: 5))
  }
}

extension WeeklyForecastResponse.Item: Stubbable {
  static func stub(withID id: String) -> WeeklyForecastResponse.Item {
    WeeklyForecastResponse.Item(date: Date(),
                                main: .stub(withID: ""),
                                weather: .stub(withCount: 3))
  }
}

extension WeeklyForecastResponse.MainClass: Stubbable {
  static func stub(withID id: String) -> WeeklyForecastResponse.MainClass {
    WeeklyForecastResponse.MainClass(temp: 23.0)
  }
}

extension WeeklyForecastResponse.Weather: Stubbable {
  static func stub(withID id: String) -> WeeklyForecastResponse.Weather {
    WeeklyForecastResponse.Weather(main: .clouds, weatherDescription: "Clouds")
  }
}
