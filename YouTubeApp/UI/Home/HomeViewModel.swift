//
//  HomeViewModel.swift
//  YouTubeApp
//
//  Created by Luis Arias on 6/9/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import Foundation

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
  
  // FIXME: Don't return nothing when this function gets connected with BE
  func getVideos() -> [Video] {
    let videos = [
      Video(name: "Video 1", duration: 12, description: "This's video one"),
      Video(name: "Video 2", duration: 12, description: "This's video two"),
      Video(name: "Video 3", duration: 12, description: "This's video three")
    ]
    
    return videos
  }
}
