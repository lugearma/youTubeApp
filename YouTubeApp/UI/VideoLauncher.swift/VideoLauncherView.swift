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
      configureControlsContainerView()
    }
  }
  
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
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureControlsContainerView() {
    guard let width = viewModel?.videoPlayerWidth else { return }
    
    controlsContainerView.frame = CGRect(x: 0, y: 0, width: width, height: width * 9/16)
    addSubview(controlsContainerView)
    
    controlsContainerView.addSubview(activityIndicatorView)
    
    activityIndicatorView.centerXAnchor.constraint(equalTo: controlsContainerView.centerXAnchor).isActive = true
    activityIndicatorView.centerYAnchor.constraint(equalTo: controlsContainerView.centerYAnchor).isActive = true
  }
  
  private func configureVideoPlayer() {
    guard let width = viewModel?.videoPlayerWidth else { return }
  
    let videoPlayerFrame = CGRect(x: 0, y: 0, width: width, height: width * 9/16)
    let videoPlayer = VideoPlayerView(frame: videoPlayerFrame, delegate: self)
    
    self.addSubview(videoPlayer)
  }
}

// MARK: - VideoPlayerViewDelegate

extension VideoLauncherView: VideoPlayerViewDelegate {
  
  func didFinishLoadVideo(_ video: VideoPlayerView) {
    activityIndicatorView.stopAnimating()
  }
}
