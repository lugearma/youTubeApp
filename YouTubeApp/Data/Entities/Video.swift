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
  let numberOfViews: NSNumber
  let uploadDate: String
  var fullSubtitle: String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    return channel.name + " ●  \(numberFormatter.string(from: numberOfViews) ?? "0") views ● " + uploadDate
  }
  
  init(name: String, duration: Int, channel: Channel, imageName: String, numberOfViews: Int, uploadDate: String) {
    self.name = name
    self.duration = duration
    self.channel = channel
    self.numberOfViews = numberOfViews as NSNumber
    self.uploadDate = uploadDate
    
    let thumbnailImage = UIImage(named: imageName)
    self.thumbnailImage = thumbnailImage
  }
}
