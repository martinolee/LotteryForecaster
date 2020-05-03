//
//  RootViewController.swift
//  LotteryForecaster
//
//  Created by Soohan Lee on 2020/05/02.
//  Copyright © 2020 Soohan Lee. All rights reserved.
//

import UIKit

final class RootViewController: UITabBarController {
  // Life Cycle
  
  override func viewDidLoad() {
    setUpTabBar()
  }
  
  private func setUpTabBar() {
    let forecasterViewController = UINavigationController(rootViewController: ForecasterViewController()).then {
      let unselectedImage = UIImage(systemName: "circle.grid.hex")
      let selectedImage = UIImage(systemName: "circle.grid.hex.fill")
      
      $0.tabBarItem = UITabBarItem(title: "Forecast", image: unselectedImage, selectedImage: selectedImage)
    }
    
    let settingViewController = UINavigationController(rootViewController: SettingViewController()).then {
      let unselectedImage = UIImage(systemName: "gear")
      let selectedImage = UIImage(systemName: "gear")
      
      $0.tabBarItem = UITabBarItem(title: "Setting", image: unselectedImage, selectedImage: selectedImage)
    }
    
    viewControllers = [
      forecasterViewController,
      settingViewController,
    ]
  }
}
