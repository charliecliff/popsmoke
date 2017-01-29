//
//  UIImageView+Tint.swift
//  Reki
//
//  Created by Charles Cliff on 9/24/16.
//  Copyright © 2016 Reki. All rights reserved.
//

import UIKit

extension UIImageView {  
  
  func renderWithColor(color: UIColor) {
    self.image? = (self.image?.withRenderingMode(.alwaysTemplate))!
    self.tintColor = color
  }
}
