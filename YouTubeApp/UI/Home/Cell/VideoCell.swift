//
//  VideoCell.swift
//  YouTubeApp
//
//  Created by Luis Arias on 6/10/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import UIKit

final class VideoCell: UICollectionViewCell {
  
  static let identifier = "VideoCellIdentifier"

  lazy var thumbnailImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .red
    return imageView
  }()
  

  var viewModel: VideoCellViewModel? {
    didSet {
      backgroundColor = viewModel?.backgroundColor
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupViews() {
    addSubview(thumbnailImageView)
    thumbnailImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
  }
}
