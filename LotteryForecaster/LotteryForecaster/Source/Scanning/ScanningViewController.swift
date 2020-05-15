//
//  ScanningViewController.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/11.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit
import ReactorKit

class ScanningViewController: UIViewController, View, ViewControllerSetup {
  // MARK: - Properties
  
  var disposeBag = DisposeBag()
  
  let scanningView = ScanningView()
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpRootView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    do {
      try ScanningManager.shared.scanQRCode(with: scanningView.cameraView)
    } catch {
      print(error.localizedDescription)
    }
    
    ScanningManager.shared.url
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        let urlRequest = URLRequest(url: $0)
        
        self.scanningView.webView.do { webView in
          webView.load(urlRequest)
          webView.isHidden = false
          
          UIView.animate(withDuration: 0.5) {
            webView.alpha = 1
          }
        }
      })
      .disposed(by: disposeBag)
  }
  
  func setUpRootView() {
    view.addSubview(scanningView)
    
    self.reactor = ScanningViewReactor()
    
    scanningView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
  
  func bind(reactor: ScanningViewReactor) {
    self.reactor = reactor
    print("bind(reactor: ScanningViewReactor")
  }
}
