//
//  VideoCellViewModel.swift
//  YouTubeApp
//
//  Created by Luis Arias on 6/10/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import Foundation

// MARK: - VideoCellVideModelDelegate

protocol VideoCellVideModelDelegate: class {
  
}

// MARK: - VideoCellViewModelProtocol

protocol VideoCellViewModelProtocol: class {
  weak var delegate: VideoCellVideModelDelegate? { get set }
}

// MARK: - VideoCellViewModel

final class VideoCellViewModel: VideoCellViewModelProtocol {
  
  weak var delegate: VideoCellVideModelDelegate?
}
