//
//  VideoCellViewModel.swift
//  YouTubeApp
//
//  Created by Luis Arias on 6/10/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import UIKit

// MARK: - VideoCellViewModelProtocol

protocol VideoCellViewModelProtocol: class {
  
  var videoTitle: String { get }
  var subtitle: String { get }
  var thumbnailVideoImage: UIImage? { get }
  var profileImage: UIImage? { get }
  var duration: Int { get }
  
  init(video: Video)
}

// MARK: - VideoCellViewModel

final class VideoCellViewModel: VideoCellViewModelProtocol {
  
  let videoTitle: String
  let subtitle: String
  let thumbnailVideoImage: UIImage?
  let profileImage: UIImage?
  let duration: Int
  
  init(video: Video) {
    self.videoTitle = video.name
    self.duration = video.duration
    self.thumbnailVideoImage = video.thumbnailImage
    self.profileImage = video.channel.profileImage
    self.subtitle = video.fullSubtitle
  }
}
