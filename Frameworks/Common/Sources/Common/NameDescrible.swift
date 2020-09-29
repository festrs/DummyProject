//
//  NameDescribable.swift
//  
//
//  Created by Felipe Dias Pereira on 29/09/20.
//

import Foundation

public protocol NameDescribable { }

public extension NameDescribable {
  var typeName: String {
    return String(describing: type(of: self))
  }

  static var typeName: String {
    return String(describing: self)
  }
}
