//
//  UITestablePage.swift
//  DummyProjectTests
//
//  Created by Felipe Dias Pereira on 23/09/20.
//  Copyright © 2020 FelipePereira. All rights reserved.
//

import Foundation
import XCTest

protocol UITestablePage {

  associatedtype UIElementType: UIElement

  func makeViewTestable(_ view: UIView, using element: UIElementType)
  func makeViewTestable(_ view: UIView, using element: UIElementType, sequence: String)
}

extension UITestablePage {

  func makeViewTestable(_ view: UIView, using element: UIElementType) {
    view.accessibilityIdentifier = element.accessibilityIdentifier
  }

  func makeViewTestable(_ view: UIView, using element: UIElementType, sequence: String) {
    view.accessibilityIdentifier = element.rawValue(withSequence: sequence)
  }
}
