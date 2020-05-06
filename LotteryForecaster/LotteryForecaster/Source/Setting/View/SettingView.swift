//
//  SettingView.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/02.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class SettingView: UIView, View {
  // MARK: - Properties
  
  var disposeBag = DisposeBag()
  
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
  
  func bind(reactor: SettingViewReactor) {
    // MARK: - State
    
    reactor.state
      .map { $0.setting }
      .bind(to: settingTableView.rx.items) { tableView, row, setting -> UITableViewCell in
        switch setting {
        case .license, .email, .rate:
          return tableView.dequeue(UITableViewCell.self).then {
            $0.textLabel?.text = setting.title
          }
          
        case .version:
          return tableView.dequeue(VersionTableViewCell.self).then {
            $0.textLabel?.text = setting.title
            
            if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
              $0.detailTextLabel?.text = "\(appVersion)"
            }
          }
        }
    }
    .disposed(by: disposeBag)
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
