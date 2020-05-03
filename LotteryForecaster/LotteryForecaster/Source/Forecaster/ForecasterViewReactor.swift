//
//  ForecasterViewReactor.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/02.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import RxSwift
import ReactorKit
import Foundation

final class ForecasterViewReactor: Reactor {
  enum Action {
    case forecast
  }
  
  enum Mutation {
    case setLottery([Int])
  }
  
  struct State {
    var forecastedLottery: [Int]?
    
    var lotteryHistory: [[Int]]
  }
  
  let initialState: State
  
  init() {
    self.initialState = State(forecastedLottery: nil, lotteryHistory: [])
  }
  
  // MARK: - Mutate
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .forecast:
      return forecastLottery()
    }
  }
  
  private func forecastLottery() -> Observable<Mutation> {
    let highestNumber = 45
    let lotteryCount = 6
    
    let forecastedLottery = Array(1...highestNumber)
      .shuffled()
      .dropLast(highestNumber - lotteryCount)
      .sorted()
    
    return Observable.just(.setLottery(forecastedLottery))
  }
  
  // MARK: - Reduct
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    
    switch mutation {
    case .setLottery(let forecastedLottery):
      if let previousForecastedLottery = state.forecastedLottery {
        state.forecastedLottery = forecastedLottery
        state.lotteryHistory.append(previousForecastedLottery)
      } else {
        state.forecastedLottery = forecastedLottery
      }
    }
    
    return state
  }
}
