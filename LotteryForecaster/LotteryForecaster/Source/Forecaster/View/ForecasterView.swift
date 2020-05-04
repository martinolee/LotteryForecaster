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
    $0.showsVerticalScrollIndicator = false
    $0.showsHorizontalScrollIndicator = false
    $0.bounces = false
    $0.bouncesZoom = false
    $0.alwaysBounceHorizontal = false
    $0.alwaysBounceVertical = false
    $0.backgroundColor = .systemBackground
    
    $0.register(cell: BallCollectionViewCell.self)
  }
  
  private lazy var forecastButton = UIButton(type: .system).then {
    $0.titleLabel?.font = .systemFont(ofSize: 30, weight: .light)
    $0.setTitle("Forecast", for: .normal)
  }
  
  private lazy var forecastedLotteryTableView = UITableView().then {
    $0.tableFooterView = UIView()
    
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
    
    setUpFlowLayout()
  }
  
  func bind(reactor: ForecasterViewReactor) {
    // MARK: - Action
    
    forecastButton.rx.tap
      .map { Reactor.Action.forecast }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    // MARK: - State
    
    reactor.state
      .map { $0.forecastedLottery ?? [] }
      .bind(to: ballsCollectionView.rx.items(cellIdentifier: BallCollectionViewCell.identifier)) { index, number, cell in
        guard let cell = cell as? BallCollectionViewCell else { return }
        
        cell.configure(number: number)
    }
    .disposed(by: disposeBag)
    
    reactor.state
      .map { $0.lotteryHistory }
      .bind(to: forecastedLotteryTableView.rx.items(cellIdentifier: ForecastedLotteryCell.identifier)) { indexPath, numbers, cell in
        guard let cell = cell as? ForecastedLotteryCell else { return }
        
        cell.configure(numbers: numbers)
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
    let safeArea = safeAreaLayoutGuide
    ballsCollectionView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(safeArea)
      $0.height.equalTo(safeArea).multipliedBy(0.45)
    }
    
    forecastButton.snp.makeConstraints {
      $0.top.equalTo(ballsCollectionView.snp.bottom).priority(.high)
      $0.centerX.equalTo(ballsCollectionView)
    }
    
    forecastedLotteryTableView.snp.makeConstraints {
      $0.top.equalTo(forecastButton.snp.bottom).offset(32)
      $0.leading.bottom.trailing.equalToSuperview()
    }
  }
  
  private func setUpFlowLayout() {
    let minimumLineSpacing: CGFloat = 0.0
    let minimumInteritemSpacing: CGFloat = 0.0
    let insets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    let itemsForLine: CGFloat = 3
    let itemSizeWidthOrHeight = (
      (
        ballsCollectionView.frame.width - (
          insets.left + insets.right + minimumInteritemSpacing * (itemsForLine - 1))
        ) / itemsForLine
      ).rounded(.down)
    let itemSize = CGSize(width: itemSizeWidthOrHeight, height: itemSizeWidthOrHeight)
    
    collectionViewFlowLayout.sectionInset = insets
    collectionViewFlowLayout.minimumLineSpacing = minimumLineSpacing
    collectionViewFlowLayout.minimumInteritemSpacing = minimumInteritemSpacing
    collectionViewFlowLayout.itemSize = itemSize
    collectionViewFlowLayout.scrollDirection = .vertical
  }
}
