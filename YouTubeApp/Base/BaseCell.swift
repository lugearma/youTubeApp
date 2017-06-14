//
//  BaseCell.swift
//  YouTubeApp
//
//  Created by Luis Arias on 6/11/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupViews(){}
}
