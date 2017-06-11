//
//  HomeCoordinator.swift
//  YouTubeApp
//
//  Created by Luis Arias on 6/10/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import UIKit

// MARK: - HomeCoordinatorDelegate

protocol HomeCoordinatorDelegate: class {
  
  func homeCoordinatorDidFinish(coordinator: Coordinator)
}

// MARK: - HomeCoordinator

final class HomeCoordinator: Coordinator {
  
  let window: UIWindow
  weak var delegate: HomeCoordinatorDelegate?
  
  init(window: UIWindow) {
    self.window = window
  }
  
  func start() {
    let homeViewController = configureHomeViewController()
    
    window.rootViewController = homeViewController
  }
  
  func configureHomeViewController() -> UINavigationController {
    
    let layout = UICollectionViewFlowLayout()
    let homeController = HomeController(collectionViewLayout: layout)
    homeController.viewModel = HomeViewModel()
    
    let navigationController = UINavigationController(rootViewController: homeController)
    
    navigationController.navigationBar.isTranslucent = false
    
    return navigationController
  }
}
