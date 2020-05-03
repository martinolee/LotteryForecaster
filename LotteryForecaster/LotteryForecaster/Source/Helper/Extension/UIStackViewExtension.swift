//
//  UIStackViewExtension.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/02.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

extension UIStackView {
  func addArrangedSubviews(_ views: [UIView]) {
    views.forEach { self.addArrangedSubview($0) }
  }
}
