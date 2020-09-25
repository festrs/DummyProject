//
//  Cache.swift
//  Common
//
//  Created by Felipe Dias Pereira on 24/09/20.
//

import Foundation

public final class Cache<Key: Hashable, Value> {
  private let wrapped = NSCache<WrappedKey, Entry>()
  private let dateProvider: () -> Date
  private let entryLifetime: TimeInterval

  public init(dateProvider: @escaping () -> Date = Date.init,
       entryLifetime: TimeInterval = 12 * 60 * 60) {
    self.dateProvider = dateProvider
    self.entryLifetime = entryLifetime
  }

  public func insert(_ value: Value, forKey key: Key) {
    let date = dateProvider().addingTimeInterval(entryLifetime)
    let entry = Entry(key: key, value: value, expirationDate: date)
    wrapped.setObject(entry, forKey: WrappedKey(key))
  }

  public func value(forKey key: Key) -> Value? {
    guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
      return nil
    }

    guard dateProvider() < entry.expirationDate else {
      // Discard values that have expired
      removeValue(forKey: key)
      return nil
    }

    return entry.value
  }

  public func removeValue(forKey key: Key) {
    wrapped.removeObject(forKey: WrappedKey(key))
  }
}

private extension Cache {
  final class Entry {
    let key: Key
    let value: Value
    let expirationDate: Date

    init(key: Key, value: Value, expirationDate: Date) {
      self.key = key
      self.value = value
      self.expirationDate = expirationDate
    }
  }
}

private extension Cache {
  final class WrappedKey: NSObject {
    let key: Key

    init(_ key: Key) { self.key = key }

    override var hash: Int { return key.hashValue }

    override func isEqual(_ object: Any?) -> Bool {
      guard let value = object as? WrappedKey else {
        return false
      }

      return value.key == key
    }
  }
}

public extension Cache {
  subscript(key: Key) -> Value? {
    get { return value(forKey: key) }
    set {
      guard let value = newValue else {
        // If nil was assigned using our subscript,
        // then we remove any value for that key:
        removeValue(forKey: key)
        return
      }

      insert(value, forKey: key)
    }
  }
}
