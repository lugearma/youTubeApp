//
//  Channel.swift
//  YouTubeApp
//
//  Created by Luis Arias on 6/14/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import UIKit

struct Channel {
  
  let name: String
  let profileImage: UIImage?
  
  init(name: String, profileImageName: String) {
    self.name = name
    
    let profileImage = UIImage(named: profileImageName)
    self.profileImage = profileImage
  }
}
