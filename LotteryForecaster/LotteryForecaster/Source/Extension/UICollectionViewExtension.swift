//
//  UICollectionViewExtension.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/03.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

extension UICollectionView {
  func register<Cell>(cell: Cell.Type, forCellReuseIdentifier reuseIdentifier: String = Cell.identifier) where Cell: UICollectionViewCell {
    register(cell, forCellWithReuseIdentifier: reuseIdentifier)
  }
}
