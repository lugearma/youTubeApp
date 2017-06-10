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
}

// MARK: HomeViewModel

final class HomeViewModel: HomeViewModelProtocol {
  
  weak var delegate: HomeViewModelDelegate?
}
