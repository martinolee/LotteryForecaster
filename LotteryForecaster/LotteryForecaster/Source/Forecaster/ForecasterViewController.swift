//
//  ForecasterViewController.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/02.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import SnapKit

final class ForecasterViewController: UIViewController, ViewControllerSetup, View {
  // MARK: - Properties
  
  var disposeBag = DisposeBag()
  
  private let forecasterView = ForecasterView()
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpRootView()
  }
  
  func bind(reactor: ForecasterViewReactor) {
    // MARK: - Action
    
    forecasterView.cameraButton.rx.tap
      .bind { [weak self] in
        guard let self = self else { return }
        
        self.present(UIViewController(), animated: true)
    }
    .disposed(by: disposeBag)

    forecasterView.forecastHistoryTableView.rx
      .itemSelected
      .bind { [weak self] indexPath in
        guard let self = self else { return }

        self.forecasterView.forecastHistoryTableView.deselectRow(at: indexPath, animated: true)
    }
    .disposed(by: disposeBag)

    forecasterView.forecastButton.rx.tap
      .map { Reactor.Action.forecast }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)

    // MARK: - State

    reactor.state
      .map { $0.forecastedLottery ?? LotteryManager.shared.setUpInitialState(highestNumber: 45) }
      .bind(to: forecasterView.ballsCollectionView.rx.items(cellIdentifier: BallCollectionViewCell.identifier)) { index, number, cell in
        guard let cell = cell as? BallCollectionViewCell else { return }

        cell.configure(number: number)
    }
    .disposed(by: disposeBag)
    
    reactor.state
      .map { $0.lotteryHistory }
      .bind(to: forecasterView.forecastHistoryTableView.rx.items(cellIdentifier: ForecastedLotteryCell.identifier)) { indexPath, numbers, cell in
        guard let cell = cell as? ForecastedLotteryCell else { return }

        cell.configure(numbers: numbers)
    }
    .disposed(by: disposeBag)
  }
  
  func setUpRootView() {
    view.addSubview(forecasterView)
    
    self.reactor = ForecasterViewReactor()
    
    forecasterView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
