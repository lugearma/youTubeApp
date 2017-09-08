//
//  HomeController.swift
//  YouTubeApp
//
//  Created by Luis Arias on 6/9/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import UIKit
import LAMenuBar
import LASettingsLauncherMenu

final class HomeController: UIViewController {
  
  private let blackView = UIView()
  private let settingsLauncher = LASettingsLauncherMenu()
  
  fileprivate var videos: [Video]?
  
  fileprivate lazy var navigationItemLabel: UILabel = {
    let label = UILabel()
    let labelFrame = CGRect(x: 0, y: 0, width: self.view.frame.width - 32, height: 32)
    
    label.frame = labelFrame
    label.textColor = .white
    label.text = "Home"
    label.font = UIFont.systemFont(ofSize: 18)
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

    setupNavigationBar()
    setupLAMenuBarView()
    getVideos()
    configureSettingLauncher()
  }
  
  private func configureSettingLauncher() {
    settingsLauncher.delegate = self
    settingsLauncher.dataSource = self
    settingsLauncher.animationOptions = .curveEaseInOut
  }
  
  private func setupLAMenuBarView() {
    
    let layout = UICollectionViewFlowLayout()
    let homeView = HomeView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: layout)
    homeView.homeViewDelegate = self
    
    let sV = UIView()
    sV.backgroundColor = UIColor(red: 255/255, green: 238/255, blue: 173/255, alpha: 1.0)
    
    let tV = UIView()
    tV.backgroundColor = UIColor(red: 255/255, green: 111/255, blue: 105/255, alpha: 1.0)
    
    let foV = UIView()
    foV.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 92/255, alpha: 1.0)
    
    let views = [homeView, sV, tV, foV]
    
    let images = [UIImage(named: "home"), UIImage(named: "trending"), UIImage(named: "subscriptions"), UIImage(named: "account")]
    let model = LAMenuModel(images: images, backgroundColor: UIColor.BaseColor.mainRed, barColor: .white, tintColorWhenSelected: .white, tintColorWhenDiselected: UIColor.BaseColor.strongRed, views: views)
    
    let menuView = LAMenuView()
    
    menuView.model = model
    menuView.configuration(delegate: self)
    
    view.addSubview(menuView)
    
    view.addConstraintsWithFormat(format: "H:|[v0]|", view: menuView)
    view.addConstraintsWithFormat(format: "V:|[v0]|", view: menuView)
  }
  
  private func setupNavigationBar() {
    navigationController?.hidesBarsOnSwipe = true
    navigationItem.titleView = navigationItemLabel
    navigationItem.rightBarButtonItems = navigationBarButtons
  }
  
  fileprivate func getVideos() {
    guard let viewModel = viewModel else { fatalError() }
    
    videos = viewModel.getVideos()
  }
  
  func handleSearch() {
    print(#function)
  }
  
  func handleMenu() {
    settingsLauncher.showSettingMenu()
  }
}

// MARK: - HomeViewModelDelegate

extension HomeController: HomeViewModelDelegate {
  
}

// MARK: - LASettingsLauncherMenuDelegate

extension HomeController: LASettingsLauncherMenuDelegate {
  
  func didHideMenu(_ menu: LASettingsLauncherMenu) {
    print(#function)
  }
  
  func settingLauncherMenu(_ menu: LASettingsLauncherMenu, didSelectItemAt indexPath: IndexPath) {
    print(#function)
  }
  
  // TODO: Present needed view controller
  private func presentNewViewController() {
    print(#function)
  }
}

// MARK: - LASettingsLauncherMenuDataSource

extension HomeController: LASettingsLauncherMenuDataSource {
  
  func dataForMenu() -> [LASettingsLauncherMenuModel] {
    
    return [
      LASettingsLauncherMenuModel(title: "Settings", image: UIImage(named: "ico-umbrella")),
      LASettingsLauncherMenuModel(title: "Profile", image: UIImage(named: "ico-profile")),
      LASettingsLauncherMenuModel(title: "Privacy", image: UIImage(named: "ico-privacy")),
      LASettingsLauncherMenuModel(title: "Help", image: UIImage(named: "ico-help")),
    ]
  }
}

// MARK: - LAMenuViewDelegate

extension HomeController: LAMenuViewDelegate {
  
  func menuView(_ view: LAMenuView, didScrollWithIndex index: IndexPath) {
    updateNavigationTitleAtIndex(index: index)
  }
  
  func menuView(_ view: LAMenuView, didSelectMenuItemAtIndex index: IndexPath) {
    updateNavigationTitleAtIndex(index: index)
  }
  
  private func updateNavigationTitleAtIndex(index: IndexPath) {
    
    // TODO: Find better way to deal with nav titles
    let names = ["Home", "Trending", "Subscriptions", "Profile"]
    
    navigationItemLabel.text = names[index.item]
  }
}

// MARK: - HomeViewDelegate

extension HomeController: HomeViewDelegate {
  
  func homView(_ view: VideoCell, didSelectItemAt indexPath: IndexPath) {
    print(#function)
  }
}

