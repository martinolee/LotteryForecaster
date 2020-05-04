//
//  SettingViewReactor.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/02.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import RxSwift
import ReactorKit
import Foundation

class SettingViewReactor: Reactor {
  enum Action {
    
  }
  
  enum Mutation {
    
  }
  
  struct State {
    let setting: [Setting] = Setting.allCases.sorted(by: <)
  }
  
  let initialState: State
  
  init() {
    self.initialState = State()
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    
  }
}
