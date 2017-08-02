//
//  BaseSettingsLauncher.swift
//  YouTubeApp
//
//  Created by Luis Arias on 7/13/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import UIKit

final class BaseSettingLauncher: NSObject {
  
  let blackView = UIView()
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectioView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectioView.backgroundColor = .white
    return collectioView
  }()
  
  var window: UIWindow {
    guard let window = UIApplication.shared.keyWindow else { fatalError() }
    return window
  }
  
  override init() {
    super.init()
    
    loadCollectionView()
  }
  
  private func loadCollectionView() {
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(BaseSettingsLauncherCell.self, forCellWithReuseIdentifier: BaseSettingsLauncherCell.identifier)
  }
  
  func showSettings() {
    
    blackView.frame = window.frame
    blackView.backgroundColor = .black
    blackView.alpha = 0
    
    let gesture = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
    blackView.addGestureRecognizer(gesture)
    
    window.addSubview(blackView)
    window.addSubview(collectionView)
    
    let height: CGFloat = 200
    let y = window.frame.height - height
    self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
    
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
      self.blackView.alpha = 0.5
      self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }, completion: nil)
  }
  
  func handleDismiss() {
    
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut,
                   animations: {
                    self.blackView.alpha = 0.0
                    self.collectionView.frame = CGRect(x: 0, y: self.window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    },
                   completion: {_ in
                    self.blackView.removeFromSuperview()
                    self.collectionView.removeFromSuperview()
    })
  }
}

extension BaseSettingLauncher: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseSettingsLauncherCell.identifier, for: indexPath) as? BaseSettingsLauncherCell else {
      fatalError("Can't dequeue cell")
    }
    
    return cell
  }
}

extension BaseSettingLauncher: UICollectionViewDelegateFlowLayout {
  
}
