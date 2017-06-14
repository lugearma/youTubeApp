//
//  Video.swift
//  YouTubeApp
//
//  Created by Luis Arias on 6/10/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import UIKit

struct Video {
  
  let name: String
  let duration: Int
  let channel: Channel
  let thumbnailImage: UIImage?
  
  init(name: String, duration: Int, channel: Channel, imageName: String) {
    self.name = name
    self.duration = duration
    self.channel = channel
    
    let thumbnailImage = UIImage(named: imageName)
    self.thumbnailImage = thumbnailImage
  }
}
