//
//  BaseView.swift
//  Common
//
//  Created by Felipe Dias Pereira on 2019-09-30.
//  Copyright © 2019 FelipePereira. All rights reserved.
//

import UIKit
/**
 **Contains the inteface elements of a screen or screen fragment**
 Contains labels, buttons, etc and is responsible for the layout.
 **Lifecycle:**
 1. `init()`
 2. `initialize()` *Add subviews*
 3. `installConstraints()` *Layout*
 - The methods themselves do nothing, it's up to the custom implementation
 */
open class BaseView: UIView {
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setup()
  }

  required public init() {
    super.init(frame: CGRect.zero)
    self.setup()
  }

  /// Default implementation does nothing
  open func initialize() { fatalError("Must be overridden") }

  /// Default implementation does nothing
  open func installConstraints() { fatalError("Must be overridden") }

  // MARK: Private
  fileprivate func setup() {
    self.initialize()
    self.installConstraints()
  }
}
