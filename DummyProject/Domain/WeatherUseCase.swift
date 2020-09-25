//
//  WeatherForecastUseCase.swift
//  DummyProject
//
//  Created by Felipe Dias Pereira on 24/09/20.
//  Copyright © 2020 FelipePereira. All rights reserved.
//

import Foundation
import Combine
import Common

protocol WeatherForecastUseCase {
  func currentWeather(at city: String) -> AnyPublisher<CurrentWeatherResponse, Error>
  func weeaklyWeatherForecast(at city: String) -> AnyPublisher<WeeklyForecastResponse, Error>
}

struct WeatherForecastUseCaseStore {
  private let repository: RepositoryWeatherForecasting = RepositoryWeatherForecast()
  private let disposableBag: DisposableBag = DisposableBag()
  private var cache: Cache<CurrentWeatherResponse.ID, CurrentWeatherResponse> = Cache(entryLifetime: 30 * 60)

  enum InternalError: Error {
    case `default`
  }
}

// MARK: - WeatherForecastUseCase

extension WeatherForecastUseCaseStore: WeatherForecastUseCase {
  func currentWeather(at city: String) -> AnyPublisher<CurrentWeatherResponse, Error> {
    if let weather = cache.value(forKey: city) {
      return Just(weather).mapError { _ -> Error in
        InternalError.default
      }.eraseToAnyPublisher()
    } else {
      let sharedPublisher = repository.currentWeather(at: city).share()

      sharedPublisher.sinkToResult { result in
        if case let .success(object) = result {
          self.cache.insert(object, forKey: city)
        }
      }.store(in: disposableBag)

      return sharedPublisher.eraseToAnyPublisher()
    }
  }

  func weeaklyWeatherForecast(at city: String) -> AnyPublisher<WeeklyForecastResponse, Error> {
    repository.weeaklyWeatherForecast(at: city)
  }
}
