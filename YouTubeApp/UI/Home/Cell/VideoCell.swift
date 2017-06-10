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
  
  lazy var separatorView: UIView = {
    let view = UIView()
    view.backgroundColor = .black
    return view
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
    addSubview(separatorView)
    
    
    // Thumbnail Image View Constraints
    addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", view: thumbnailImageView)
    addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", view: thumbnailImageView)
    
    //Separator View Constraints
    addConstraintsWithFormat(format: "H:|[v0]|", view: separatorView)
    addConstraintsWithFormat(format: "V:[v0(1)]|", view: separatorView)
  }
}
