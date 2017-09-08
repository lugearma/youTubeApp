//
//  VideoPlayerViewModel.swift
//  YouTubeApp
//
//  Created by Luis Arias on 9/8/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import Foundation

protocol VideoPlayerViewModelProtocol: class {
  
  var videoName: String { get }
  
  init(videoName: String)
}

class VideoPlayerViewModel: VideoPlayerViewModelProtocol {
  
  let videoName: String
  
  required init(videoName: String) {
    self.videoName = videoName
  }
}
