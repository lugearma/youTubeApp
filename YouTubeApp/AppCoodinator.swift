//
//  AppCoodinator.swift
//  YouTubeApp
//
//  Created by Luis Arias on 6/10/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import UIKit

// MARK: - AppCoordinatorFlow

enum AppCoordinatorFlow {
  
  case homeCoordinator
}

// MARK: - AppCoordinatorProtocol

protocol AppCoordinatorProtocol: class {
  
  var window: UIWindow { get }
  
  init(window: UIWindow)
  
}

// MARK: - AppCoodinator

final class AppCoodinator: Coordinator, AppCoordinatorProtocol {
  
  var window: UIWindow
  var coordinators = [AppCoordinatorFlow: Coordinator]()
  
  init(window: UIWindow) {
    self.window = window
  }
  
  func start() {
    showHome()
  }
}

// MARK: - HomeCoordinatorDelegate

extension AppCoodinator: HomeCoordinatorDelegate {
  
  func showHome() {
    let coordinator = HomeCoordinator(window: window)
    coordinators[.homeCoordinator] = coordinator
    
    coordinator.delegate = self
    coordinator.start()
  }
}
