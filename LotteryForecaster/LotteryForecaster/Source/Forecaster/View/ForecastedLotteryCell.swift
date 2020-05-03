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
  
  let forecastedBallsStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.distribution = .fillEqually
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
    
    var balls = [UILabel]()
    for _ in 1 ... 6 {
      let label = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.clipsToBounds = true
      }
      balls.append(label)
    }
    
    forecastedBallsStackView.addArrangedSubviews(balls)
  }
  
  private func setUpAutoLayout() {
    forecastedBallsStackView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
}
