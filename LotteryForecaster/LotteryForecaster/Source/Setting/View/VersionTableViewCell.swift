//
//  VersionTableViewCell.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/05.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

/// value1 style cell
class VersionTableViewCell: UITableViewCell {
  // Life Cycle
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .value1, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
