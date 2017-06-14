//
//  VideoCell.swift
//  YouTubeApp
//
//  Created by Luis Arias on 6/10/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import UIKit

final class VideoCell: BaseCell {
  
  static let identifier = "VideoCellIdentifier"

  lazy var thumbnailImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "imageOne")
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  lazy var userProfileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "img-profile")
    imageView.layer.cornerRadius = 22
    imageView.layer.masksToBounds = true
    return imageView
  }()
  
  lazy var separatorView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red: 230/250, green: 230/250, blue: 230/250, alpha: 1)
    return view
  }()
  
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Song One by me"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var subtitleTextView: UITextView = {
    let textView = UITextView()
    textView.text = "lugeBB ● 2,345,532 view ● 2 years ago"
    textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
    textView.textColor = .lightGray
    textView.translatesAutoresizingMaskIntoConstraints = false
    return textView
  }()

  var viewModel: VideoCellViewModel? {
    didSet {
      
    }
  }
  
  override func setupViews() {
    super.setupViews()
    
    addSubview(thumbnailImageView)
    addSubview(userProfileImageView)
    addSubview(separatorView)
    addSubview(titleLabel)
    addSubview(subtitleTextView)
    
    // Horizontal Constraints
    addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", view: thumbnailImageView)
    addConstraintsWithFormat(format: "H:|-16-[v0(44)]|", view: userProfileImageView)
    addConstraintsWithFormat(format: "H:|[v0]|", view: separatorView)
    
    // Vertical Contraints
    addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", view: thumbnailImageView, userProfileImageView, separatorView)
    
    // Top Contraints
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
    
    // Left Constraints
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
    
    //Right Constraints
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
    
    //Height Constraints
    addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
  }
}
