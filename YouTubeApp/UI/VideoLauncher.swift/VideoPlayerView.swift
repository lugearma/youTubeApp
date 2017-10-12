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
  
  weak var delegate: VideoPlayerViewDelegate?
  var viewModel: VideoPlayerViewModel?
  var videoPlayer: AVPlayer!
  
  var isPlayingVideo = true {
    didSet {
      let name: String
      name = isPlayingVideo ? "ico-pause" : "ico-play"
      pausePlayButton.setImage(UIImage(named: name), for: .normal)
    }
  }
  
  lazy var pausePlayButton: UIButton = {
    let button = UIButton(type: .system)
    let image = UIImage(named: "ico-pause")
    button.setImage(image, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.tintColor = .white
    button.isHidden = true
    button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
    return button
  }()
  
  lazy var controlsContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
    return view
  }()
  
  lazy var activityIndicatorView: UIActivityIndicatorView = {
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
    activityIndicatorView.startAnimating()
    return activityIndicatorView
  }()
  
  init(frame: CGRect, delegate: VideoPlayerViewDelegate? = nil) {
    super.init(frame: frame)
    
    self.delegate = delegate
    
    backgroundColor = .black
    configureVideoPlayer()
    configureControlsContainerView(frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func handlePause() {
    if isPlayingVideo {
      videoPlayer.pause()
    } else {
      videoPlayer.play()
    }
    isPlayingVideo = !isPlayingVideo
  }
  
  private func configureVideoPlayer() {
    
    if let url = URL(string: "http://techslides.com/demos/sample-videos/small.mp4") {
      videoPlayer = AVPlayer(url: url)
      
      let playerLayer = AVPlayerLayer(player: videoPlayer)
      self.layer.addSublayer(playerLayer)
      playerLayer.frame = self.frame
      
      videoPlayer.play()
      
      videoPlayer.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
    }
  }
  
  private func configureControlsContainerView(_ frame: CGRect) {
    
    controlsContainerView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width * 9/16)
    addSubview(controlsContainerView)
    
    controlsContainerView.addSubview(activityIndicatorView)
    
    activityIndicatorView.centerXAnchor.constraint(equalTo: controlsContainerView.centerXAnchor).isActive = true
    activityIndicatorView.centerYAnchor.constraint(equalTo: controlsContainerView.centerYAnchor).isActive = true
    
    controlsContainerView.addSubview(pausePlayButton)
    
    pausePlayButton.centerXAnchor.constraint(equalTo: controlsContainerView.centerXAnchor).isActive = true
    pausePlayButton.centerYAnchor.constraint(equalTo: controlsContainerView.centerYAnchor).isActive = true
    pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    activityIndicatorView.stopAnimating()
    controlsContainerView.backgroundColor = .clear
    pausePlayButton.isHidden = false
  }
}
