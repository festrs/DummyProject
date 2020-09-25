//
//  LoadableTests.swift
//  Common
//
//  Created by Felipe Dias Pereira on 14/09/20.
//

import XCTest
import Combine
@testable import Common

final class LoadableTests: XCTestCase {
  enum TestingError: Error {
    case `default`
  }

  func testEquality() {
    let possibleValues: [Loadable<Int>] = [
      .notRequested,
      .isLoading(last: nil, disposableBag: DisposableBag()),
      .isLoading(last: 9, disposableBag: DisposableBag()),
      .loaded(5),
      .loaded(6),
      .failed(TestingError.default)
    ]

    possibleValues.enumerated().forEach { (index1, value1) in
      possibleValues.enumerated().forEach { (index2, value2) in
        if index1 == index2 {
          XCTAssertEqual(value1, value2)
        } else {
          XCTAssertNotEqual(value1, value2)
        }
      }
    }
  }

  func testCancelLoading() {
    let cancenBag1 = DisposableBag(), cancenBag2 = DisposableBag()
    let subject = PassthroughSubject<Int, Never>()
    subject.sink { _ in }
      .store(in: cancenBag1)
    subject.sink { _ in }
      .store(in: cancenBag2)
    var sut1 = Loadable<Int>.isLoading(last: nil, disposableBag: cancenBag1)
    XCTAssertEqual(cancenBag1.subscriptions.count, 1)
    sut1.cancelLoading()
    XCTAssertEqual(cancenBag1.subscriptions.count, 0)
    XCTAssertNotNil(sut1.error)
    var sut2 = Loadable<Int>.isLoading(last: 7, disposableBag: cancenBag2)
    XCTAssertEqual(cancenBag2.subscriptions.count, 1)
    sut2.cancelLoading()
    XCTAssertEqual(cancenBag2.subscriptions.count, 0)
    XCTAssertEqual(sut2.value, 7)
  }

  func testMap() {
    let values: [Loadable<Int>] = [
      .notRequested,
      .isLoading(last: nil, disposableBag: DisposableBag()),
      .isLoading(last: 5, disposableBag: DisposableBag()),
      .loaded(7),
      .failed(TestingError.default)
    ]
    let expect: [Loadable<String>] = [
      .notRequested,
      .isLoading(last: nil, disposableBag: DisposableBag()),
      .isLoading(last: "5", disposableBag: DisposableBag()),
      .loaded("7"),
      .failed(TestingError.default)
    ]
    let sut = values.map { value in
      value.map { "\($0)" }
    }
    XCTAssertEqual(sut, expect)
  }

  func testHelperFunctions() {
    let notRequested = Loadable<Int>.notRequested
    let loadingNil = Loadable<Int>.isLoading(last: nil, disposableBag: DisposableBag())
    let loadingValue = Loadable<Int>.isLoading(last: 9, disposableBag: DisposableBag())
    let loaded = Loadable<Int>.loaded(5)
    let failedErrValue = Loadable<Int>.failed(TestingError.default)
    [notRequested, loadingNil].forEach {
      XCTAssertNil($0.value)
    }
    [loadingValue, loaded].forEach {
      XCTAssertNotNil($0.value)
    }
    [notRequested, loadingNil, loadingValue, loaded].forEach {
      XCTAssertNil($0.error)
    }
    XCTAssertNotNil(failedErrValue.error)
  }

  func testThrowingMap() {
    let value = Loadable<Int>.loaded(5)
    let sut = value.map { _ in throw TestingError.default }
    XCTAssertNotNil(sut.error)
  }

  func testValueIsMissing() {
    XCTAssertEqual(ValueIsMissingError().localizedDescription, "Data is missing")
  }
}
