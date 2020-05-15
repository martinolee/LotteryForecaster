//
//  ScanningView.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/11.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit
import WebKit

class ScanningView: UIView, ViewSetup {
  // MARK: - Properties
  
  var cameraView = UIView()
  
  let webView = WKWebView().then {
    $0.isHidden = true
    $0.alpha = 0
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
  
  // MARK: - UI setup
  
  func setUpAttribute() {
    self.backgroundColor = .systemBackground
  }
  
  func addAllSubviews() {
    self.addSubviews([
      cameraView,
      webView
    ])
  }
  
  func setUpAutoLayout() {
    cameraView.snp.makeConstraints { $0.edges.equalToSuperview() }
    
    webView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
}
