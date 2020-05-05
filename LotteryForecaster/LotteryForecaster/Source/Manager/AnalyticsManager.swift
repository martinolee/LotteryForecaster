//
//  AnalyticsManager.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/05.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import Foundation
import FirebaseAnalytics

class AnalyticsManager {
  static let shared = AnalyticsManager()
  
  func makeLogEvent(_ logEvent: LogEvent) {
    Analytics.logEvent(logEvent.title, parameters: nil)
  }
  
  private init() { }
}

enum LogEvent {
  case forecast
  
  var title: String {
    switch self {
    case .forecast:
      return "forecast"
    }
  }
}
