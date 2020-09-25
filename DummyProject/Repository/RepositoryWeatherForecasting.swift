//
//  WeatherRepository.swift
//  DummyProject
//
//  Created by Felipe Dias Pereira on 23/09/20.
//  Copyright © 2020 FelipePereira. All rights reserved.
//

import Foundation
import Networking
import Combine
import Common

fileprivate enum OpenWeatherAPI {
  static let host = "api.openweathermap.org"
  static let key = "28cffbebec615b29a27ef652ecb2df5d"
}

protocol RepositoryWeatherForecasting {
  func currentWeather(at city: String) -> AnyPublisher<CurrentWeatherResponse, Error>
  func weeaklyWeatherForecast(at city: String) -> AnyPublisher<WeeklyForecastResponse, Error>
}

struct RepositoryWeatherForecast: RepositoryWeatherForecasting {
  private let service: NetworkService

  init(service: NetworkService = NetworkService(host: OpenWeatherAPI.host)) {
    self.service = service
  }

  func currentWeather(at city: String) -> AnyPublisher<CurrentWeatherResponse, Error> {
    service.request(.currentWeather(city: city))
      .mapError { networkError -> Error in
        // Handle any networking error here
        networkError as Error
    }.eraseToAnyPublisher()
  }

  func weeaklyWeatherForecast(at city: String) -> AnyPublisher<WeeklyForecastResponse, Error> {
    let request: NetworkRequest = .weaklyWeatherForecast(city: city)
    return service.request(request)
      .mapError { networkError -> Error in
        // Handle any networking error here
        networkError as Error
    }.eraseToAnyPublisher()
  }
}

// MARK: - Endpoint

private extension NetworkEndpoint {
  static func currentWeather(city: String) -> Self {
    NetworkEndpoint(path: "/data/2.5/weather", queryItems: ["q": city,
                                                   "mode": "json",
                                                   "units": "metric",
                                                   "APPID": OpenWeatherAPI.key])
  }

  static func weaklyWeatherForecast(city: String) -> Self {
    NetworkEndpoint(path: "/data/2.5/forecast", queryItems: ["q": city,
                                                   "mode": "json",
                                                   "units": "metric",
                                                   "APPID": OpenWeatherAPI.key])
  }

}

// MARK: - Request

private extension NetworkRequest {
  static func currentWeather(city: String) -> Self {
    NetworkRequest(endpoint: .currentWeather(city: city))
  }

  static func weaklyWeatherForecast(city: String) -> Self {
    NetworkRequest(endpoint: .weaklyWeatherForecast(city: city))
  }
}
