//
//  Copying.swift
//  TicTacToeGame
//
//  Created by Станислав Лемешаев on 18.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import Foundation

protocol Copying {
  init(_ prototype: Self)
}

extension Copying {
  func makeCopy() -> Self {
    return type(of: self).init(self)
  }
}
