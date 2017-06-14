//
//  UIColor.swift
//  YouTubeApp
//
//  Created by Luis Arias on 6/11/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import UIKit

extension UIColor {
  
  static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
      return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
  }
  
  struct BaseColor {
    
    static let mainRed: UIColor = {
      return UIColor.rgb(red: 230, green: 32, blue: 31)
    }()
    
    static let statusBarRed: UIColor = {
      return UIColor.rgb(red: 194, green: 31, blue: 31)
    }()
  }
}
