//
//  ForecasterViewController.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/02.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit
import SnapKit

final class ForecasterViewController: UIViewController {
  // MARK: - Properties
  
  private let forecasterView = ForecasterView()
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpRootView()
  }
  
  private func setUpRootView() {
    forecasterView.reactor = ForecasterViewReactor()
    
    view.addSubview(forecasterView)
    
    forecasterView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
}
