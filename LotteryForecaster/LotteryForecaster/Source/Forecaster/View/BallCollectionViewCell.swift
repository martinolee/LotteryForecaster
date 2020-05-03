//
//  BallCollectionViewCell.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/03.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class BallCollectionViewCell: UICollectionViewCell {
  // MARK: - Property
  
  private lazy var numberLabel = UILabel().then {
    $0.clipsToBounds = true
    $0.font = .systemFont(ofSize: 24, weight: .light)
  }
  
  // MARK - Life Cycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUpAttribute()
    addAllSubviews()
    setUpAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK - SetUp UI
  
  private func setUpAttribute() {
    
  }
  
  private func addAllSubviews() {
    contentView.addSubview(numberLabel)
  }
  
  private func setUpAutoLayout() {
    numberLabel.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  // MARK: - Element Control
  
  func configure(number: Int) {
    numberLabel.text = "\(number)"
  }
}
