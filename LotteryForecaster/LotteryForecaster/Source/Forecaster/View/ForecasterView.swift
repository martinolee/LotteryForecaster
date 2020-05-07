//
//  ForecasterView.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/02.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit
import Then

final class ForecasterView: UIView, ViewSetup {
  // MARK: - Properties
  
  enum UI {
    case rowHeight
    
    var cgFloat: CGFloat {
      switch self {
      case .rowHeight:
        return 50
      }
    }
  }
  
  let cameraButton = UIButton(type: .system).then {
    $0.setImage(UIImage(systemName: "camera"), for: .normal)
  }
  
  var collectionViewFlowLayout = UICollectionViewFlowLayout()
  
  lazy var ballsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout).then {
    $0.showsVerticalScrollIndicator = false
    $0.showsHorizontalScrollIndicator = false
    $0.bounces = false
    $0.bouncesZoom = false
    $0.alwaysBounceHorizontal = false
    $0.alwaysBounceVertical = false
    $0.backgroundColor = .systemBackground
    
    $0.register(cell: BallCollectionViewCell.self)
  }
  
  var forecastButton = UIButton(type: .system).then {
    $0.titleLabel?.font = .systemFont(ofSize: 30, weight: .light)
    $0.setTitle("Forecast", for: .normal)
  }
  
  var forecastHistoryTableView = UITableView().then {
    $0.rowHeight = UI.rowHeight.cgFloat
    $0.tableFooterView = UIView()
    
    $0.register(cell: ForecastedLotteryCell.self)
  }
  
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
  
  // MARK: - Setup UI
  
  func setUpAttribute() {
    self.backgroundColor = .systemBackground
  }
  
  func addAllSubviews() {
    self.addSubviews([
      ballsCollectionView,
      forecastHistoryTableView,
      forecastButton,
    ])
  }
  
  func setUpAutoLayout() {
    let safeArea = safeAreaLayoutGuide
    
    ballsCollectionView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(safeArea)
      $0.height.equalTo(safeArea).multipliedBy(0.45)
    }
    
    forecastButton.snp.makeConstraints {
      $0.top.equalTo(ballsCollectionView.snp.bottom).priority(.high)
      $0.centerX.equalTo(ballsCollectionView)
    }
    
    forecastHistoryTableView.snp.makeConstraints {
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
