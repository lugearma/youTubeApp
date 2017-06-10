//
//  VideoCell.swift
//  YouTubeApp
//
//  Created by Luis Arias on 6/10/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import UIKit

final class VideoCell: UICollectionViewCell {
  
  @IBOutlet weak var nameVideoLabel: UILabel!
  
  var viewModel: VideoCellViewModel? {
    didSet {
      //nameVideoLabel.text = viewModel?.videoName
      backgroundColor = viewModel?.backgroundColor
    }
  }
}
