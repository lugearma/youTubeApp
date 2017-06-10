//
//  HomeController.swift
//  YouTubeApp
//
//  Created by Luis Arias on 6/9/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import UIKit

final class HomeController: UICollectionViewController {
  
  private(set) var model: HomeViewModelProtocol? {
    willSet {
      model?.delegate = nil
    }
    
    didSet {
      model?.delegate = self
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Home"
    
    collectionView?.backgroundColor = .red
    loadCollectionView()
  }
  
  func loadCollectionView() {
    collectionView?.delegate = self
    collectionView?.dataSource = self
  }
}

// MARK: UICollectionViewDataSource

extension HomeController {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath)
    return cell
  }
}

// MARK: UICollectionViewDelegate

extension HomeController {
  
}

// MARK: HomeViewModelDelegate

extension HomeController: HomeViewModelDelegate {
  
}

