//
//  VideoLauncherViewModel.swift
//  YouTubeApp
//
//  Created by Luis Arias on 9/8/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import Foundation

protocol VideoLauncherViewModelProtocol: class {
  
  var videoName: String { get }
  var videoPlayerWidth: Int { get }
  
  init(videoName: String, videoPlayerWidth: Int)
}

class VideoLauncherViewModel: VideoLauncherViewModelProtocol {
  
  let videoName: String
  let videoPlayerWidth: Int
  
  required init(videoName: String, videoPlayerWidth: Int) {
    self.videoName = videoName
    self.videoPlayerWidth = videoPlayerWidth
  }
}
