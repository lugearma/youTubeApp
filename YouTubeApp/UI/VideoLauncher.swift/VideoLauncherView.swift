//
//  VideoLauncherView.swift
//  YouTubeApp
//
//  Created by Luis Arias on 9/8/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import UIKit

final class VideoLauncherView: UIView {
  
  var viewModel: VideoLauncherViewModel? {
    didSet {
      configureVideoPlayer()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureVideoPlayer() {
    guard let width = viewModel?.videoPlayerWidth else { return }
  
    let videoPlayerFrame = CGRect(x: 0, y: 0, width: width, height: width * 9/16)
    let videoPlayer = VideoPlayerView(frame: videoPlayerFrame)
    
    self.addSubview(videoPlayer)
  }
}
