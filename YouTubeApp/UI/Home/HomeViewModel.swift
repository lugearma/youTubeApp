//
//  HomeViewModel.swift
//  YouTubeApp
//
//  Created by Luis Arias on 6/9/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import UIKit

// MARK: HomeViewModelDelegate

protocol HomeViewModelDelegate: class {}

// MARK: HomeViewModelProtocol

protocol HomeViewModelProtocol: class {
  
  weak var delegate: HomeViewModelDelegate? { get set }
  
  func getVideos() -> [Video]
}

// MARK: HomeViewModel

final class HomeViewModel: HomeViewModelProtocol {
  
  weak var delegate: HomeViewModelDelegate?

  func getVideos() -> [Video] {
    let videos = [
      Video(name: "Video 1sdfsdfsdfsdfsdfsdfsdfds", duration: 12, channel: Channel(name: "Stranbo", profileImageName: "img-profile-two"), imageName: "imgThree", numberOfViews: 122342, uploadDate: "2 months ago"),
      Video(name: "Video 2", duration: 12, channel: Channel(name: "Lola", profileImageName: "img-profile"), imageName: "imageOne", numberOfViews: 122342, uploadDate: "3 weeks ago"),
      Video(name: "Video 1sdfsdfsdfsdfsdfsdfsdfds", duration: 12, channel: Channel(name: "Stranbo", profileImageName: "img-profile-two"), imageName: "imgThree", numberOfViews: 122342, uploadDate: "2 months ago"),
      Video(name: "Video 2", duration: 12, channel: Channel(name: "Lola", profileImageName: "img-profile"), imageName: "imageOne", numberOfViews: 122342, uploadDate: "3 weeks ago"),
      Video(name: "Video 1sdfsdfsdfsdfsdfsdfsdfds", duration: 12, channel: Channel(name: "Stranbo", profileImageName: "img-profile-two"), imageName: "imgThree", numberOfViews: 122342, uploadDate: "2 months ago"),
      Video(name: "Video 2", duration: 12, channel: Channel(name: "Lola", profileImageName: "img-profile"), imageName: "imageOne", numberOfViews: 122342, uploadDate: "3 weeks ago")
    ]
    
    return videos
  }
}
