//
//  SettingView.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/02.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

class SettingView: UIView {
  // MARK: - Properties
  
  lazy var settingTableView = UITableView().then {
    $0.tableFooterView = UIView()
    
    $0.register(cell: UITableViewCell.self)
    $0.register(cell: VersionTableViewCell.self)
  }
  
  // MARK: - Life Cycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUpAttribute()
    addAllSubview()
    setUpAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Set Up UI
  
  private func setUpAttribute() {
    self.backgroundColor = .systemBackground
  }
  
  private func addAllSubview() {
    self.addSubviews([
      settingTableView
    ])
  }
  
  private func setUpAutoLayout() {
    settingTableView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
}
