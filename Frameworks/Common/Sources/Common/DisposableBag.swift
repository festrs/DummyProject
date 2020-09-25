//
//  CancelBag.swift
//  Common
//
//  Created by Felipe Dias Pereira on 14/09/20.
//

import Combine

public final class DisposableBag {
  var subscriptions = Set<AnyCancellable>()

  func cancelAndClear() {
    subscriptions.forEach { $0.cancel() }
    subscriptions.removeAll()
  }

  public init() { }
}

public extension AnyCancellable {

  func store(in disposableBag: DisposableBag) {
    disposableBag.subscriptions.insert(self)
  }
}
