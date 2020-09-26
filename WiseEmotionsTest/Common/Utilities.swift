//
//  Utilities.swift
//  WiseEmotionsTest
//
//  Created by Filippo Giove on 25/09/2020.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import Foundation

final class Box<T> {
  //1
  typealias Listener = (T) -> Void
  var listener: Listener?
  //2
  var value: T {
    didSet {
      listener?(value)
    }
  }
  //3
  init(_ value: T) {
    self.value = value
  }
  //4
  func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}
