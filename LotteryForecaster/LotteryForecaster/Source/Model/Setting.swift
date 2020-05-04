//
//  Setting.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/04.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

enum Setting {
  case license, version, rate, email
}

extension Setting {
  var title: String {
    switch self {
    case .license:
      return "License"
    case .version:
      return "Version"
    case .rate:
      return "Rate Lottery Forecaster"
    case .email:
      return "Send mail to Lottery Forecaster"
    }
  }
  
  var id: Int {
    switch self {
    case .license:
      return 0
    case .version:
      return 1
    case .rate:
      return 2
    case .email:
      return 3
    }
  }
}

extension Setting: Comparable {
  static func <(lhs: Setting, rhs: Setting) -> Bool {
    return lhs.id < rhs.id
  }
}

extension Setting: CaseIterable {
}
