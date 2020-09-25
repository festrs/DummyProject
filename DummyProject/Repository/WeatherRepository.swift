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

fileprivate enum OpenWeatherAPI {
  static let host = "api.openweathermap.org/data/2.5"
  static let key = "28cffbebec615b29a27ef652ecb2df5d"
}

protocol WeatherForecastRepository {
  func forecastWeather(at city: String) -> AnyPublisher<CurrentWeatherForecastResponse, Error>
}

struct WeatherRepositorable: WeatherForecastRepository {
  private let service: NetworkService

  init(service: NetworkService = NetworkService(host: OpenWeatherAPI.host)) {
    self.service = service
  }

  func forecastWeather(at city: String) -> AnyPublisher<CurrentWeatherForecastResponse, Error> {
    service.request(.weather(city: city))
      .mapError { networkError -> Error in
        // Handle any networking error here
        networkError as Error
    }.eraseToAnyPublisher()
  }
}

// MARK: - Endpoint

private extension NetworkEndpoint {
  static func weather(city: String) -> Self {
    NetworkEndpoint(path: "/weather", queryItems: ["q": city,
                                                   "mode": "json",
                                                   "units": "metric",
                                                   "APPID": OpenWeatherAPI.key])
  }
}

// MARK: - Request

private extension NetworkRequest {
  static func weather(city: String) -> Self {
    NetworkRequest(endpoint: .weather(city: city))
  }
}
