//
//  ScanningViewReactor.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/11.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation
import ReactorKit

class ScanningViewReactor: Reactor {
  enum Action {
    case scan(UIView)
  }
  
  enum Mutation {
    case setURL(URL)
  }
  
  struct State {
    var scannedURL: URL?
  }
  
  let initialState: State
  
  init() {
    self.initialState = State()
  }
  
  func mutate(action: Action) -> Observable<Action> {
    switch action {
    case .scan(let view):
      do {
        try ScanningManager.shared.scanQRCode(with: view)
      } catch {
        print(error.localizedDescription)
      }
      return Observable.just(action)
    }
  }
}
