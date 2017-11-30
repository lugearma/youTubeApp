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
  
  lazy var videoLengthLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.text = "00:00"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textAlignment = .right
    return label
  }()
  
  lazy var currentProgressVideoLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.text = "00:00"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textAlignment = .left
    return label
  }()
  
  lazy var videoProgressSlider: UISlider = {
    let slider = UISlider()
    slider.tintColor = UIColor.BaseColor.mainRed
    slider.minimumTrackTintColor = UIColor.BaseColor.mainRed
    slider.translatesAutoresizingMaskIntoConstraints = false
    slider.maximumTrackTintColor = .white
    let thumbImage = CustomThumb.image(CGSize(width: 15, height: 15))
    slider.setThumbImage(thumbImage, for: .normal)
    slider.addTarget(self, action: #selector(handleSliderValueChange), for: .valueChanged)
    return slider
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .black
    setupGradientLayer()
    setupVideoPlayer()
    setupControlsContainerView(frame)
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
  
  func handleSliderValueChange() {
    if let duration = videoPlayer.currentItem?.duration {
      let totalSeconds = CMTimeGetSeconds(duration)
      let value = CMTimeValue(Float64(videoProgressSlider.value) * totalSeconds)
      let seekTime = CMTime(value: value, timescale: 1)
      videoPlayer.seek(to: seekTime)
    }
  }
  
  private func setupGradientLayer() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = bounds
    gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
    gradientLayer.locations = [0.7, 1.3]
    
    controlsContainerView.layer.addSublayer(gradientLayer)
  }
  
  private func setupVideoPlayer() {
    if let filePath = Bundle.main.path(forResource: "sampleVideo", ofType: ".mp4") {
      let url = URL(fileURLWithPath: filePath)
      videoPlayer = AVPlayer(url: url)
      
      let playerLayer = AVPlayerLayer(player: videoPlayer)
      self.layer.addSublayer(playerLayer)
      playerLayer.frame = self.frame
      
      videoPlayer.play()
      videoPlayer.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
      
      let interval = CMTime(value: 1, timescale: 2)
      videoPlayer.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) { progressTime in
        let seconds = CMTimeGetSeconds(progressTime)
        let secondsStrings = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60.0)))
        let minutesStrings = String(format: "%02d", Int(seconds / 60))
        
        self.currentProgressVideoLabel.text = "\(minutesStrings):\(secondsStrings)"
        
        if let duration = self.videoPlayer.currentItem?.duration {
          let durationSeconds = CMTimeGetSeconds(duration)
          let currentValue = Float(seconds / durationSeconds)
          self.videoProgressSlider.value = currentValue
        }
        
      }
    }
  }
  
  private func setupControlsContainerView(_ frame: CGRect) {
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
    
    controlsContainerView.addSubview(videoLengthLabel)
    
    videoLengthLabel.rightAnchor.constraint(equalTo: controlsContainerView.rightAnchor, constant: -8).isActive = true
    videoLengthLabel.bottomAnchor.constraint(equalTo: controlsContainerView.bottomAnchor).isActive = true
    videoLengthLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
    videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    
    controlsContainerView.addSubview(currentProgressVideoLabel)
    
    currentProgressVideoLabel.leftAnchor.constraint(equalTo: controlsContainerView.leftAnchor, constant: 8).isActive = true
    currentProgressVideoLabel.bottomAnchor.constraint(equalTo: controlsContainerView.bottomAnchor).isActive = true
    currentProgressVideoLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
    currentProgressVideoLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    
    controlsContainerView.addSubview(videoProgressSlider)
    
    videoProgressSlider.leftAnchor.constraint(equalTo: currentProgressVideoLabel.rightAnchor, constant: 8).isActive = true
    videoProgressSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor, constant: -8).isActive = true
    videoProgressSlider.bottomAnchor.constraint(equalTo: controlsContainerView.bottomAnchor, constant: -4).isActive = true
    currentProgressVideoLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "currentItem.loadedTimeRanges" {
      activityIndicatorView.stopAnimating()
      controlsContainerView.backgroundColor = .clear
      pausePlayButton.isHidden = false
      
      //TODO: Make a Double extension for this
      if let seconds = videoPlayer.currentItem?.duration.seconds {
        let secondsText = Int(seconds.truncatingRemainder(dividingBy: 60))
        let secondsString = String(format: "%02d", secondsText)
        let minutesText = Int(seconds.divided(by: 60))
        let minutesString = String(format: "%02d", minutesText)
        
        videoLengthLabel.text = minutesString + ":" + secondsString
      }
    }
  }
}

// MARK: - CustomThumb

extension VideoPlayerView {
  fileprivate class CustomThumb: UIView {
    
    private var color: UIColor!
    
    init(frame: CGRect, color: UIColor) {
      super.init(frame: frame)
      self.color = color
      backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
      color.setStroke()
      color.setFill()
      
      let circle = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
      circle.lineWidth = 0
      circle.fill()
      circle.stroke()
    }
    
    class func image(_ size: CGSize) -> UIImage? {
      let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
      let view = CustomThumb(frame: frame, color: UIColor.BaseColor.mainRed)
      
      UIGraphicsBeginImageContextWithOptions(size, false, 0)
      view.drawHierarchy(in: frame, afterScreenUpdates: true)
      let image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      
      return image
    }
  }
}
