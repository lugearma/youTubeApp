//
//  HomeController.swift
//  YouTubeApp
//
//  Created by Luis Arias on 6/9/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import UIKit

final class HomeController: UICollectionViewController {
  
  fileprivate var videos: [Video]?
  private let blackView = UIView()
  private let settingsLauncher = BaseSettingLauncher()
  
  private lazy var navigationItemLabel: UILabel = {
    let label = UILabel()
    let labelFrame = CGRect(x: 0, y: 0, width: self.view.frame.width - 32, height: self.view.frame.height)
    
    label.frame = labelFrame
    label.textColor = .white
    label.text = "Home"
    label.font = UIFont.systemFont(ofSize: 20)
    return label
  }()
  
  private lazy var navigationBarButtons: [UIBarButtonItem] = {
    let searchImage = UIImage(named: "ico-search")?.withRenderingMode(.alwaysOriginal)
    let menuImage = UIImage(named: "ico-menu")?.withRenderingMode(.alwaysOriginal)
    
    let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
    let menuBarButtonItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(handleMenu))
    
    let navigationbarButtons = [menuBarButtonItem, searchBarButtonItem]
    
    return navigationbarButtons
  }()
  
  // TODO: Change type when pod is ready
  private lazy var menuBar: UIView = {
    let menuBar = UIView()
    menuBar.backgroundColor = UIColor.BaseColor.mainRed
    return menuBar
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
    loadMenuBar()
    getVideos()
  }
  
  private func loadCollectionView() {
    collectionView?.delegate = self
    collectionView?.dataSource = self
    collectionView?.backgroundColor = .white
    collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: VideoCell.identifier)
  }
  
  private func loadNavigationBar() {
    navigationController?.hidesBarsOnSwipe = true
    navigationItem.titleView = navigationItemLabel
    navigationItem.rightBarButtonItems = navigationBarButtons
  }
  
  fileprivate func loadMenuBar() {
    
    let redView = UIView()
    redView.backgroundColor = UIColor.BaseColor.mainRed
    
    //Contraints for redView
    view.addSubview(redView)
    view.addConstraintsWithFormat(format: "H:|[v0]|", view: redView)
    view.addConstraintsWithFormat(format: "V:[v0(50)]", view: redView)
    
    // Constraints for menuBar
    view.addSubview(menuBar)
    view.addConstraintsWithFormat(format: "H:|[v0]|", view: menuBar)
    view.addConstraintsWithFormat(format: "V:[v0(50)]", view: menuBar)
    
    menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
  }
  
  fileprivate func getVideos() {
    guard let viewModel = viewModel else { fatalError() }
    
    videos = viewModel.getVideos()
  }
  
  func handleSearch() {}
  
  func handleMenu() {
    settingsLauncher.showSettings()
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
    return CGSize(width: collectionView.frame.width, height: height + 16 + 88)
  }
}

// MARK: - HomeViewModelDelegate

extension HomeController: HomeViewModelDelegate {
  
}

