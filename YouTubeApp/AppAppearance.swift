//
//  AppAppearance.swift
//  YouTubeApp
//
//  Created by Luis Arias on 6/11/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import UIKit

extension AppDelegate {
  
  func customizeAppearance(_ window: UIWindow) {
    UINavigationBar.appearance().barTintColor = UIColor.BaseColor.mainRed
    UINavigationBar.appearance().shadowImage = UIImage()
    UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    
    let statusBarBackgoundView = UIView()
    statusBarBackgoundView.backgroundColor = UIColor.BaseColor.statusBarRed
    window.addSubview(statusBarBackgoundView)
    
    window.addConstraintsWithFormat(format: "H:|[v0]|", view: statusBarBackgoundView)
    window.addConstraintsWithFormat(format: "V:|[v0(20)]", view: statusBarBackgoundView)
  }
}
