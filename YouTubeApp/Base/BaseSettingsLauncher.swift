//
//  BaseSettingsLauncher.swift
//  YouTubeApp
//
//  Created by Luis Arias on 7/13/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import UIKit

final class BaseSettingLauncher: NSObject {
  
  let blackView = UIView()
  
  override init() {
    super.init()
  }
  
  func showSettings() {
    
    guard let window = UIApplication.shared.keyWindow else { fatalError() }
    
    blackView.frame = window.frame
    blackView.backgroundColor = .black
    blackView.alpha = 0
    
    let gesture = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
    blackView.addGestureRecognizer(gesture)
    
    window.addSubview(blackView)
    
    UIView.animate(withDuration: 0.5) {
      self.blackView.alpha = 0.5
    }
  }
  
  func handleDismiss() {
    UIView.animate(withDuration: 0.5, animations: {
      UIView.animate(withDuration: 0.5) {
        self.blackView.alpha = 0.0
      }
    }) { completion in
      
      guard let window = UIApplication.shared.keyWindow else { fatalError() }
      window.willRemoveSubview(self.blackView)
    }
  }
}
