//
//  Identifiable.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/02.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

protocol Identifiable {
  static var identifier: String { get }
}

extension Identifiable {
  static var identifier: String { String(describing: self) }
}
