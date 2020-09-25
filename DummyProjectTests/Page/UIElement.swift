//
//  UIElement.swift
//  DummyProjectTests
//
//  Created by Felipe Dias Pereira on 23/09/20.
//  Copyright © 2020 FelipePereira. All rights reserved.
//

import Foundation
import XCTest

protocol UIElement: RawRepresentable {

  var accessibilityIdentifier: String { get }
}

extension UIElement {
  var accessibilityIdentifier: RawValue {
    return self.rawValue
  }
}

extension UIElement where Self: ExpressibleByStringLiteral {

}
