//
//  LotteryManager.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/03.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation

class LotteryManager {
  static let shared = LotteryManager()
  
  func raffleLottery(highestNumber: Int, lotteryCount: Int) -> [Int] {
    let forecastedLottery = Array(1...highestNumber)
      .shuffled()
      .dropLast(highestNumber - lotteryCount)
      .sorted()
    
    return forecastedLottery
  }
  
  func setUpInitialState(highestNumber: Int) -> [Int] {
    let forecastedLottery = Array(1...highestNumber)
      .shuffled()
    
    return forecastedLottery 
  }
  
  private init() { }
}
