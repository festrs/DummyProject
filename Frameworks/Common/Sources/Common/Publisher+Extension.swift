//
//  Publisher+Extension.swift
//  Common
//
//  Created by Felipe Dias Pereira on 14/09/20.
//

import Combine

public extension Publisher {
  func sinkToResult(_ result: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
    return sink(receiveCompletion: { completion in
      switch completion {
      case let .failure(error):
        result(.failure(error))
      default: break
      }
    }, receiveValue: { value in
      result(.success(value))
    })
  }

  func sinkToLoadable(_ completion: @escaping (Loadable<Output>) -> Void) -> AnyCancellable {
    return sink(receiveCompletion: { subscriptionCompletion in
      if case .failure(let error) = subscriptionCompletion {
        completion(.failed(error))
      }
    }, receiveValue: { value in
      completion(.loaded(value))
    })
  }
}
