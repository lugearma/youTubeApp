//
//  HomeView.swift
//  YouTubeApp
//
//  Created by Luis Arias on 9/1/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import UIKit

protocol HomeViewDelegate: class {
  
  func homView(_ view: VideoCell, didSelectItemAt indexPath: IndexPath)
}

final class HomeView: UICollectionView {
  
  weak var homeViewDelegate: HomeViewDelegate?

  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    
    backgroundColor = .white
    self.register(VideoCell.self, forCellWithReuseIdentifier: VideoCell.identifier)
    self.delegate = self
    self.dataSource = self
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - UICollectionViewDelegate

extension HomeView: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath) as? VideoCell else { return }
    homeViewDelegate?.homView(cell, didSelectItemAt: indexPath)
  }
}

// MARK: - UICollectionViewDataSource

extension HomeView: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.identifier, for: indexPath) as? VideoCell else { fatalError() }
    let videoCellViewModel = VideoCellViewModel(video: Video(name: "Hola", duration: 2, channel: Channel(name: "Hola", profileImageName: "img-profile"), imageName: "img-one", numberOfViews: 23, uploadDate: "Hola"))
    
    cell.viewModel = videoCellViewModel
    
    return cell
  }
}

extension HomeView: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.frame.width - 32, height: 300)
  }
  
}
