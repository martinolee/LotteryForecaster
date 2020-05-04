//
//  Ballr.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/04.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

enum Ball {
  case number(Int)
  
  var color: UIColor? {
    switch self {
    case .number(let number):
      switch number {
      case 1...9:
        return .lotteryYellow
      case 10...19:
        return .lotteryBlue
      case 20...29:
        return .lotteryRed
      case 30...39:
        return .lotteryBlack
      case 40...45:
        return .lotteryGreen
      default:
        return nil
      }
    }
  }
}
