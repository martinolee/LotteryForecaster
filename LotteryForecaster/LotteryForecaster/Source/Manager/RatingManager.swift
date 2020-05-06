//
//  RatingManager.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/04.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit
import StoreKit

class RatingManager {
  static let shared = RatingManager()
  
  func rateThisApp() {
    SKStoreReviewController.requestReview()
  }
  
  private init() { }
}
