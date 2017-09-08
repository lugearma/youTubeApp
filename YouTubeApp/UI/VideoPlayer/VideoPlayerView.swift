//
//  VideoPlayerView.swift
//  YouTubeApp
//
//  Created by Luis Arias on 9/8/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import UIKit

final class VideoPlayerView: UIView {
  
  var viewModel: VideoPlayerViewModel? {
    didSet {
      
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .red
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
