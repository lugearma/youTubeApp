//
//  ViewController.swift
//  YouTubeApp
//
//  Created by Luis Arias on 6/9/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import UIKit

final class HomeController: UICollectionViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Home"
    
    collectionView?.backgroundColor = .red
  }
}

