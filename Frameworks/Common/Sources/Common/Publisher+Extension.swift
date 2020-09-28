//
//  Publisher+Extension.swift
//  Common
//
//  Created by Felipe Dias Pereira on 14/09/20.
//

import Combine

public extension Publisher {
  typealias ResultOutput = Result<Output, Failure>

  func sinkToResult(_ result: @escaping (ResultOutput) -> Void) -> AnyCancellable {
    return sink(receiveCompletion: { completion in
      switch completion {
      case let .failure(error):
        result(.failure(error))
      default: break
      }
    }, receiveValue: {  value in
      result(.success(value))
    })
  }
  
  func sinkToResult<Object: AnyObject>(for object: Object,
                                       _ result: @escaping (Object, ResultOutput) -> Void) -> AnyCancellable {
    return sink(receiveCompletion: { [weak object] completion in
      guard let object = object else { return }
      switch completion {
      case let .failure(error):
        result(object, .failure(error))
      default: break
      }
      }, receiveValue: { [weak object] value in
        guard let object = object else { return }
        result(object, .success(value))
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

  func sinkToLoadable<Object: AnyObject>(for object: Object,
                                         _ result: @escaping (Object, Loadable<Output>) -> Void) -> AnyCancellable {
    return sink(receiveCompletion: { [weak object] subscriptionCompletion in
      guard let object = object else { return }
      if case .failure(let error) = subscriptionCompletion {
        result(object, .failed(error))
      }
      }, receiveValue: { [weak object] value in
        guard let object = object else { return }
        result(object, .loaded(value))
    })
  }
}
