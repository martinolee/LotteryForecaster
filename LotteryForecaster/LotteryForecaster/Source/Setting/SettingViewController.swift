//
//  SettingViewController.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/02.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit
import MessageUI
import RxSwift
import AcknowList

class SettingViewController: UIViewController {
  // MARK: - Properties
  
  private let disposeBag = DisposeBag()
  
  private let settingView = SettingView()
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpRootView()
    bind()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    deselectRow(animated)
  }
  
  private func setUpRootView() {
    settingView.reactor = SettingViewReactor()
    
    view.addSubview(settingView)
    
    settingView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  // MARK: - Action
  
  private func bind() {
    settingView.settingTableView.rx.itemSelected
      .subscribe({ [weak self] indexPath in
        guard let self = self, let navigationController = self.navigationController else { return }
        
        switch indexPath {
        case .next(let indexPath):
          switch indexPath.row {
          case Setting.license.id:
            let viewController = AcknowListViewController()
            
            navigationController.pushViewController(viewController, animated: true)
            
          case Setting.version.id:
            print("version")
            
          case Setting.rate.id:
            print("rate")
            
          case Setting.email.id:
            let developerEmail = "soohan.m.lee@gmail.com"
            let emailViewController = EmailManager.shared.getEmailComposeView(for: developerEmail)
            
            if MFMailComposeViewController.canSendMail() {
              self.present(emailViewController, animated: true)
            }
          default:
            break
          }
          
        case .error(let error):
          print(error.localizedDescription)
          
        case .completed:
          print("completed")
        }
      })
      .disposed(by: disposeBag)
  }
  
  private func deselectRow(_ animated: Bool) {
    if let indexPath = settingView.settingTableView.indexPathForSelectedRow {
      settingView.settingTableView.deselectRow(at: indexPath, animated: animated)
    }
  }
}
