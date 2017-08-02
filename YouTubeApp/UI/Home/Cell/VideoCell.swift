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
  
  lazy var nameVideoLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 2
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
  
  var titleLabelConstraint: NSLayoutConstraint?

  var viewModel: VideoCellViewModel? {
    didSet {
      nameVideoLabel.text = viewModel?.videoTitle
      userProfileImageView.image = viewModel?.profileImage
      thumbnailImageView.image = viewModel?.thumbnailVideoImage
      subtitleTextView.text = viewModel?.subtitle
      
      resizeTitleLabelHeightIfNedded()
    }
  }
  
  override func setupViews() {
    super.setupViews()
    
    addSubview(thumbnailImageView)
    addSubview(userProfileImageView)
    addSubview(separatorView)
    addSubview(nameVideoLabel)
    addSubview(subtitleTextView)
    
    // Horizontal Constraints
    addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", view: thumbnailImageView)
    addConstraintsWithFormat(format: "H:|-16-[v0(44)]|", view: userProfileImageView)
    addConstraintsWithFormat(format: "H:|[v0]|", view: separatorView)
    
    // Vertical Contraints
    addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", view: thumbnailImageView, userProfileImageView, separatorView)
    
    // Top Contraints
    addConstraint(NSLayoutConstraint(item: nameVideoLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: nameVideoLabel, attribute: .bottom, multiplier: 1, constant: 4))
    
    // Left Constraints
    addConstraint(NSLayoutConstraint(item: nameVideoLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
    
    //Right Constraints
    addConstraint(NSLayoutConstraint(item: nameVideoLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
    
    //Height Constraints
    titleLabelConstraint = NSLayoutConstraint(item: nameVideoLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20)
    addConstraint(self.titleLabelConstraint!)
    addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
  }
  
  fileprivate func resizeTitleLabelHeightIfNedded() {
    
    guard let videoTitle = viewModel?.videoTitle else { return }
    
    let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
    let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
    let estimatedRect = NSString(string: videoTitle).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
    
    if estimatedRect.size.height > 20 {
      titleLabelConstraint?.constant = 44
    }
  }
}
