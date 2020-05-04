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
    if #available(iOS 10.3, *) {
      SKStoreReviewController.requestReview()
    } else {
      guard let rateGitGetUrl = URL(string: "") else { return }
      UIApplication.shared.open(rateGitGetUrl)
      UIApplication.shared.canOpenURL(rateGitGetUrl)
    }
  }
  
  private init() { }
}
