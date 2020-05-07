//
//  ViewSetup.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/07.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit.UIView

protocol ViewSetup where Self: UIView {
  func setUpAttribute()
  
  func addAllSubviews()
  
  func setUpAutoLayout()
}
