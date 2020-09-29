//
//  WeatherUseCase+SwiftUI.swift
//  DummyProject
//
//  Created by Felipe Dias Pereira on 29/09/20.
//  Copyright © 2020 FelipePereira. All rights reserved.
//

import Combine

// MARK: - Mock

struct WeatherForecastUseCaseMock: WeatherForecastUseCase {
  func currentWeather(at city: String) -> AnyPublisher<CurrentWeatherResponse, Error> {
    Just<CurrentWeatherResponse>(.stub(withID: "123"))
      .mapError { _ in WeatherForecastUseCaseStore.InternalError.default }
      .eraseToAnyPublisher()
  }

  func weeaklyWeatherForecast(at city: String) -> AnyPublisher<WeeklyForecastResponse, Error> {
    Just<WeeklyForecastResponse>(.stub(withID: "123"))
      .mapError { _ in WeatherForecastUseCaseStore.InternalError.default }
      .eraseToAnyPublisher()
  }
}
