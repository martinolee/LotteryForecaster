//
//  ForecastedLotteryCell.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/02.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class ForecastedLotteryCell: UITableViewCell {
  // MARK: - Properties
  
  enum UI: CGFloat {
    case width = 30
  }
  
  private let forecastedBallsStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.distribution = .fillEqually
    $0.spacing = 30
    
    $0.addArrangedSubviews([UILabel(), UILabel(), UILabel(), UILabel(), UILabel(), UILabel()])
    
    guard let labels = $0.arrangedSubviews as? [UILabel] else { return }
    let width = UI.width.rawValue
    labels.forEach {
      $0.do { label in
        label.textAlignment = .center
        label.textColor = .white
        label.clipsToBounds = true
        label.layer.cornerRadius = width / 2
        
        label.snp.makeConstraints {
          $0.width.equalTo(width)
          $0.height.equalTo(label.snp.width)
        }
      }
    }
  }
  
  // MARK: - Life Cycle
  
  override init(style:
    UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setUpAttribute()
    addAllSubviews()
    setUpAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup UI
  
  private func setUpAttribute() {
    
  }
  
  private func addAllSubviews() {
    contentView.addSubview(forecastedBallsStackView)
  }
  
  private func setUpAutoLayout() {
    forecastedBallsStackView.snp.makeConstraints { $0.center.equalToSuperview() }
  }
  
  // MARK: - Element Control
  
  func configure(numbers: [Int]) {
    for index in numbers.indices {
      guard let ball = forecastedBallsStackView.arrangedSubviews[index] as? UILabel else { return }
      let number = numbers[index]
      
      ball.text = "\(number)"
      ball.backgroundColor = Ball.number(number).color
    }
  }
}
