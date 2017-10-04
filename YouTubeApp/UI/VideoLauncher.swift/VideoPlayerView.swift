//
//  VideoPlayerView.swift
//  YouTubeApp
//
//  Created by Luis Arias on 9/8/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import UIKit
import AVFoundation

protocol VideoPlayerViewDelegate: class {
  
  func didFinishLoadVideo(_ video: VideoPlayerView)
}

final class VideoPlayerView: UIView {
  
  var viewModel: VideoPlayerViewModel?
  weak var delegate: VideoPlayerViewDelegate?
  
  init(frame: CGRect, delegate: VideoPlayerViewDelegate? = nil) {
    super.init(frame: frame)
    
    self.delegate = delegate
    
    backgroundColor = .black
    configureVideoPlayer()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureVideoPlayer() {
    
    if let url = URL(string: "http://techslides.com/demos/sample-videos/small.mp4") {
      let videoPlayer = AVPlayer(url: url)
      
      let playerLayer = AVPlayerLayer(player: videoPlayer)
      self.layer.addSublayer(playerLayer)
      playerLayer.frame = self.frame
      
      videoPlayer.play()
      
      videoPlayer.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
    }
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    delegate?.didFinishLoadVideo(self)
    print("Hey, video is playing 😗")
  }
}
