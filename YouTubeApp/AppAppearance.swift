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
    UINavigationBar.appearance().barTintColor = UIColor.rgb(red: 230, green: 32, blue: 31)
    
    let statusBarBackgoundView = UIView()
    statusBarBackgoundView.backgroundColor = UIColor.rgb(red: 194, green: 31, blue: 31)
    window.addSubview(statusBarBackgoundView)
    
    window.addConstraintsWithFormat(format: "H:|[v0]|", view: statusBarBackgoundView)
    window.addConstraintsWithFormat(format: "V:|[v0(20)]", view: statusBarBackgoundView)
  }
}
