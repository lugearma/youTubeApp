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
  
  private lazy var navigationItemLabel: UILabel = {
    let label = UILabel()
    let labelFrame = CGRect(x: 0, y: 0, width: self.view.frame.width - 32, height: 32)
    
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
  }
  
  private func setupLAMenuBarView() {
    
    let fV = UIView()
    fV.backgroundColor = UIColor(red: 150/255, green: 206/255, blue: 180/255, alpha: 1.0)
    
    let sV = UIView()
    sV.backgroundColor = UIColor(red: 255/255, green: 238/255, blue: 173/255, alpha: 1.0)
    
    let tV = UIView()
    tV.backgroundColor = UIColor(red: 255/255, green: 111/255, blue: 105/255, alpha: 1.0)
    
    let foV = UIView()
    foV.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 92/255, alpha: 1.0)
    
    let views = [fV, sV, tV, foV]
    
    let images = [UIImage(named: "home"), UIImage(named: "trending"), UIImage(named: "subscriptions"), UIImage(named: "account")]
    let model = LAMenuModel(images: images, backgroundColor: UIColor.BaseColor.mainRed, barColor: .white, tintColorWhenSelected: .white, tintColorWhenDiselected: UIColor.BaseColor.strongRed, views: views)
    
    let menuView = LAMenuView()
    
    menuView.model = model
    
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

