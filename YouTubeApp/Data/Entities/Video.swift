//
//  Video.swift
//  YouTubeApp
//
//  Created by Luis Arias on 6/10/17.
//  Copyright © 2017 Luis Arias. All rights reserved.
//

import Foundation

struct Video {
  
  let name: String
  let duration: Int
  let description: String
  
  init(name: String, duration: Int, description: String) {
    self.name = name
    self.duration = duration
    self.description = description
  }
}
