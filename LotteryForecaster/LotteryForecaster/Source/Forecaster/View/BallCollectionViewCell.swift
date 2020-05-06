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
  
  enum UI {
    case inset
    
    var cgFloat: CGFloat {
      switch self {
      case .inset:
        return 32
      }
    }
  }
  
  private lazy var numberLabel = UILabel().then {
    $0.clipsToBounds = true
    $0.layer.cornerRadius = (UIScreen.main.bounds.width / 3 - UI.inset.cgFloat * 2) / 2
    $0.font = .systemFont(ofSize: 28, weight: .bold)
    $0.textAlignment = .center
    $0.textColor = .white
    $0.text = "?"
  }
  
  // MARK - Life Cycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUpAttribute()
    addAllSubviews()
    setUpAutoLayout()
//    makeCircleLabel()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
//    makeCircleLabel()
  }
  
  // MARK - SetUp UI
  
  private func setUpAttribute() {
    self.backgroundColor = .systemBackground
  }
  
  private func addAllSubviews() {
    contentView.addSubview(numberLabel)
  }
  
  private func setUpAutoLayout() {
    numberLabel.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(UI.inset.cgFloat)
    }
  }
  
  private func makeCircleLabel() {
    numberLabel.layer.cornerRadius = numberLabel.frame.width / 2
  }
  
  // MARK: - Element Control
  
  func configure(number: Int) {
    numberLabel.text = "\(number)"
    
    numberLabel.backgroundColor = Ball.number(number).color
  }
}
