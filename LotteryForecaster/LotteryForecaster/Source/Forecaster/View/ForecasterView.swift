//
//  ForecasterView.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/02.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import Then

final class ForecasterView: UIView, View {
  // MARK: - Properties
  
  var disposeBag = DisposeBag()
  
  private lazy var collectionViewFlowLayout = UICollectionViewFlowLayout()
  
  private lazy var ballsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout).then {
    $0.register(cell: BallCollectionViewCell.self)
  }
  
  private lazy var forecastButton = UIButton(type: .system).then {
    $0.setTitle("Forecast", for: .normal)
  }
  
  private lazy var forecastedLotteryTableView = UITableView().then {
    $0.register(cell: ForecastedLotteryCell.self)
  }
  
  private lazy var button: UIButton = {
    let button = UIButton()
    
    button.setTitle("Forecast", for: .normal)
    
    return button
  }()
  
  // MARK: - Life Cycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUpAttribute()
    addAllSubviews()
    setUpAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
  
  func bind(reactor: ForecasterViewReactor) {
    // MARK: - Action
    
    forecastButton.rx.tap
      .map { Reactor.Action.forecast }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    // MARK: - State
    
    reactor.state
      .map { $0.lotteryHistory }
      .bind(to: forecastedLotteryTableView.rx.items(cellIdentifier: ForecastedLotteryCell.identifier)) { indexPath, lotteryHistory, cell in
        guard let cell = cell as? ForecastedLotteryCell else { return }
        for index in lotteryHistory.indices {
          guard let ball = cell.forecastedBallsStackView.arrangedSubviews[index] as? UILabel else { return }
          
          ball.text = "\(lotteryHistory[index])"
        }
    }
    .disposed(by: disposeBag)
    
    reactor.state
      .map { $0.forecastedLottery ?? [] }
      .bind(to: ballsCollectionView.rx.items(cellIdentifier: BallCollectionViewCell.identifier)) { index, number, cell in
        guard let cell = cell as? BallCollectionViewCell else { return }
        
        cell.configure(number: number)
    }
    .disposed(by: disposeBag)
  }
  
  // MARK: - Setup UI
  
  private func setUpAttribute() {
    self.backgroundColor = .systemBackground
  }
  
  private func addAllSubviews() {
    self.addSubviews([
      ballsCollectionView,
      forecastedLotteryTableView,
      forecastButton,
    ])
  }
  
  private func setUpAutoLayout() {
    ballsCollectionView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(safeAreaLayoutGuide)
      $0.height.equalToSuperview().multipliedBy(0.5)
    }
    
    forecastButton.snp.makeConstraints {
      $0.top.equalTo(ballsCollectionView.snp.bottom)
      $0.centerX.equalTo(ballsCollectionView)
    }
    
    forecastedLotteryTableView.snp.makeConstraints {
      $0.leading.bottom.trailing.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(0.5)
    }
  }
}
