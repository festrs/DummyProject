//
//  UIElementPage.swift
//  DummyProjectTests
//
//  Created by Felipe Dias Pereira on 23/09/20.
//  Copyright © 2020 FelipePereira. All rights reserved.
//

import XCTest

class UIElementPage<T: UIElement>: Page {

  override init(element: XCUIElement) {
    super.init(element: element)
  }

  init(root: T) {
    super.init(element: Page.app.otherElements[root])
  }

  func label(_ element: T) -> XCUIElement {
    return self.element.staticTexts[element]
  }

  func textField(_ element: T) -> XCUIElement {
    return self.element.textFields[element]
  }

  func textView(_ element: T) -> XCUIElement {
    return self.element.textViews[element]
  }

  func staticText(_ element: T) -> XCUIElement {
    return self.element.staticTexts[element]
  }

  func button(_ element: T) -> XCUIElement {
    return self.element.buttons[element]
  }

  func image(_ element: T) -> XCUIElement {
    return self.element.images[element]
  }

  func table(_ element: T) -> XCUIElement {
    return self.element.tables[element]
  }

  func collection(_ element: T) -> XCUIElement {
    return self.element.collectionViews[element]
  }

  func otherElement(_ element: T) -> XCUIElement {
    return self.element.otherElements[element]
  }
}
