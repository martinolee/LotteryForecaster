//
//  EmailManager.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/04.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit
import MessageUI

class EmailManager {
  static let shared = EmailManager()
  
  private func configuredMailComposeViewController(emailAddress:String, systemVersion:String, appVersion:String) -> MFMailComposeViewController {
    let mailComposerVC = MFMailComposeViewController()
    
    mailComposerVC.setToRecipients([emailAddress])
    mailComposerVC.setSubject("Feedback for Lottery Forecaster")
    mailComposerVC.setMessageBody(
      String(
        format: NSLocalizedString(
          "\nThanks for your feedback!\nKindly write your advice here. :)\n\n\n=====\niOS Version: %@\nApp Version: %@\n=====",
          comment: ""), systemVersion, appVersion),
      isHTML: false
    )
    
    return mailComposerVC
  }
  
  func getEmailComposeView(for developerEmail: String) -> MFMailComposeViewController {
    let userSystemVersion = UIDevice.current.systemVersion
    guard let userAppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else { fatalError() }
    
    let mailComposeViewController = self.configuredMailComposeViewController(
      emailAddress: developerEmail,
      systemVersion: userSystemVersion,
      appVersion: userAppVersion
    )
    
    return mailComposeViewController
  }
  
  private init() { }
}
