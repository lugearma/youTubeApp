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
  
  let pauseButton: UIButton = {
    let button = UIButton(type: .system)
    let image = UIImage(named: "ico-pause")
    button.setImage(image, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.tintColor = .white
    button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
    return button
  }()
  
  let controlsContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
    return view
  }()
  
  let activityIndicatorView: UIActivityIndicatorView = {
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
    print("Pause Video")
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
  
  private func configureControlsContainerView(_ frame: CGRect) {
    
    controlsContainerView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width * 9/16)
    addSubview(controlsContainerView)
    
    controlsContainerView.addSubview(activityIndicatorView)
    
    activityIndicatorView.centerXAnchor.constraint(equalTo: controlsContainerView.centerXAnchor).isActive = true
    activityIndicatorView.centerYAnchor.constraint(equalTo: controlsContainerView.centerYAnchor).isActive = true
    
    controlsContainerView.addSubview(pauseButton)
    pauseButton.centerXAnchor.constraint(equalTo: controlsContainerView.centerXAnchor).isActive = true
    pauseButton.centerYAnchor.constraint(equalTo: controlsContainerView.centerYAnchor).isActive = true
    pauseButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    pauseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    activityIndicatorView.stopAnimating()
    controlsContainerView.backgroundColor = .clear
  }
}
