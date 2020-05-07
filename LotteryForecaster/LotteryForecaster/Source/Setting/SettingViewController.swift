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
import ReactorKit
import AcknowList

class SettingViewController: UIViewController, View {
  // MARK: - Properties
  
  var disposeBag = DisposeBag()
  
  private let settingView = SettingView()
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpRootView()
  }
  
  private func setUpRootView() {
    self.reactor = SettingViewReactor()
    
    view.addSubview(settingView)
    
    settingView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  // MARK: - Action
  
  func bind(reactor: SettingViewReactor) {
    // MARK: - State
    
    reactor.state
      .map { $0.setting }
      .bind(to: settingView.settingTableView.rx.items) { tableView, row, setting -> UITableViewCell in
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
    
    // MARK: - Action
    
    settingView.settingTableView.rx.itemSelected
      .bind { [weak self] indexPath in
        guard let self = self, let navigationController = self.navigationController else { return }
        self.settingView.settingTableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case Setting.license.id:
          let viewController = AcknowListViewController(fileNamed: "Pods-LotteryForecaster-acknowledgements")
          
          navigationController.pushViewController(viewController, animated: true)
          
        case Setting.version.id:
          print("version")
          
        case Setting.rate.id:
          RatingManager.shared.rateThisApp()
          
        case Setting.email.id:
          let developerEmail = "soohan.m.lee@gmail.com"
          let emailViewController = EmailManager.shared.getEmailComposeView(for: developerEmail)
          emailViewController.mailComposeDelegate = self
          
          if MFMailComposeViewController.canSendMail() {
            self.present(emailViewController, animated: true)
          }
        default:
          break
        }
    }
    .disposed(by: disposeBag)
  }
}

extension SettingViewController: MFMailComposeViewControllerDelegate {
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true)
  }
}
