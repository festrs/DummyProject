//
//  Loadable.swift
//  Common
//
//  Created by Felipe Dias Pereira on 14/09/20.
//

import Foundation
import SwiftUI

public typealias LoadableBiding<Value> = Binding<Loadable<Value>>

public enum Loadable<T> {
  case notRequested
  case isLoading(last: T?, disposableBag: DisposableBag)
  case loaded(T)
  case failed(Error)

  var value: T? {
    switch self {
    case let .loaded(value): return value
    case let .isLoading(last, _): return last
    default: return nil
    }
  }
  var error: Error? {
    switch self {
    case let .failed(error): return error
    default: return nil
    }
  }
}

public extension Loadable {

  mutating func setIsLoading(disposableBag: DisposableBag) {
    self = .isLoading(last: value, disposableBag: disposableBag)
  }

  mutating func cancelLoading() {
    switch self {
    case let .isLoading(last, disposableBag):
        disposableBag.cancelAndClear()
        if let last = last {
          self = .loaded(last)
        } else {
          let error = NSError(
            domain: NSCocoaErrorDomain, code: NSUserCancelledError,
            userInfo: [NSLocalizedDescriptionKey: NSLocalizedString("Canceled by user",
                                                                    comment: "")])
          self = .failed(error)
        }
    default: break
    }
  }

  func map<V>(_ transform: (T) throws -> V) -> Loadable<V> {
    do {
      switch self {
      case .notRequested: return .notRequested
      case let .failed(error): return .failed(error)

      case let .isLoading(value, disposableBag):
          return .isLoading(last: try value.map { try transform($0) },
                            disposableBag: disposableBag)
        
      case let .loaded(value):
          return .loaded(try transform(value))
      }
    } catch {
      return .failed(error)
    }
  }
}

public protocol SomeOptional {
  associatedtype Wrapped
  func unwrap() throws -> Wrapped
}

public struct ValueIsMissingError: Error {
  var localizedDescription: String {
    NSLocalizedString("Data is missing", comment: "")
  }
}

extension Optional: SomeOptional {
  public func unwrap() throws -> Wrapped {
    switch self {
    case let .some(value): return value
    case .none: throw ValueIsMissingError()
    }
  }
}

public extension Loadable where T: SomeOptional {
  func unwrap() -> Loadable<T.Wrapped> {
    map { try $0.unwrap() }
  }
}

extension Loadable: Equatable where T: Equatable {
  public static func == (lhs: Loadable<T>, rhs: Loadable<T>) -> Bool {
    switch (lhs, rhs) {
    case (.notRequested, .notRequested): return true
    case let (.isLoading(lhsV, _), .isLoading(rhsV, _)): return lhsV == rhsV
    case let (.loaded(lhsV), .loaded(rhsV)): return lhsV == rhsV
    case let (.failed(lhsE), .failed(rhsE)): return lhsE.localizedDescription == rhsE.localizedDescription
    default: return false
    }
  }
}
