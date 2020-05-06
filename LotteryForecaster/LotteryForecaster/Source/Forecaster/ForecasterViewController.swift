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
import SnapKit

final class ForecasterViewController: UIViewController {
  // MARK: - Properties
  
  private let disposeBag = DisposeBag()
  
  private let forecasterView = ForecasterView()
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpRootView()
    setUpNavigationItem()
  }
  
  private func setUpRootView() {
    forecasterView.reactor = ForecasterViewReactor()
    
    view.addSubview(forecasterView)
    
    forecasterView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  private func setUpNavigationItem() {
    let cameraButton = UIButton(type: .system).then {
      $0.setImage(UIImage(systemName: "camera"), for: .normal)
    }
    
    cameraButton.rx.tap
      .bind { [weak self] in
        guard let self = self else { return }
        
        self.present(UIViewController(), animated: true)
    }
    .disposed(by: disposeBag)
    
//    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cameraButton)
  }
}
