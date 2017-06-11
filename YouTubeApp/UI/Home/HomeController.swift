//
//  HomeController.swift
//  YouTubeApp
//
//  Created by Luis Arias on 6/9/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import UIKit

final class HomeController: UICollectionViewController {
  
  var videos: [Video]?
  
  lazy var navigationItemLabel: UILabel = {
    let label = UILabel()
    let labelFrame = CGRect(x: 0, y: 0, width: self.view.frame.width - 32, height: self.view.frame.height)
    
    label.frame = labelFrame
    label.textColor = .white
    label.text = "Home"
    label.font = UIFont.systemFont(ofSize: 20)
    return label
  }()
  
  var viewModel: HomeViewModelProtocol? {
    willSet {
      viewModel?.delegate = nil
    }
    
    didSet {
      viewModel?.delegate = self
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    loadNavigationBar()
    loadCollectionView()
    getVideos()
  }
  
  func loadCollectionView() {
    collectionView?.delegate = self
    collectionView?.dataSource = self
    collectionView?.backgroundColor = .white
    collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: VideoCell.identifier)
  }
  
  func loadNavigationBar() {
    navigationItem.titleView = navigationItemLabel
  }
  
  func getVideos() {
    guard let viewModel = viewModel else { fatalError() }
    
    videos = viewModel.getVideos()
  }
}

// MARK: - UICollectionViewDataSource

extension HomeController {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return videos?.count ?? 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let video = videos?[indexPath.row] else { fatalError() }
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.identifier, for: indexPath) as? VideoCell else { fatalError() }
    
    let cellVM = VideoCellViewModel(video: video)
    
    cell.viewModel = cellVM
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = (collectionView.frame.width - 32) * 9/16
    return CGSize(width: collectionView.frame.width, height: height + 16 + 68)
  }
}

// MARK: - HomeViewModelDelegate

extension HomeController: HomeViewModelDelegate {
  
}

