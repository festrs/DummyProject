//
//  Page.swift
//  DummyProjectTests
//
//  Created by Felipe Dias Pereira on 23/09/20.
//  Copyright © 2020 FelipePereira. All rights reserved.
//

import Foundation
import XCTest

class Page {

  static let app = XCUIApplication()

  let element: XCUIElement

  init(element: XCUIElement) {
    self.element = element
  }
}
