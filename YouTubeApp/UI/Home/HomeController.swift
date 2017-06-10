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
    collectionView?.backgroundColor = .white

    loadCollectionView()
  }
  
  func loadCollectionView() {
    collectionView?.delegate = self
    collectionView?.dataSource = self
    collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
  }
}

// MARK: UICollectionViewDataSource

extension HomeController {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
    
    cell.backgroundColor = .red
    
    return cell
  }
}

extension HomeController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: 200)
  }
}

// MARK: HomeViewModelDelegate

extension HomeController: HomeViewModelDelegate {
  
}

