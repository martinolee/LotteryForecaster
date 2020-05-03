//
//  AppDelegate.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/01.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    setUpRootViewController()
    
    return true
  }
  
  private func setUpRootViewController() {
    window = UIWindow(frame: UIScreen.main.bounds)
    guard let window = window else { return }
    let rootViewController = RootViewController()
    
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
  }
}

