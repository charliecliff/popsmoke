//
//  UILabel+Size.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/25/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

extension UILabel {
	
	func requiredHeight() -> CGFloat{
		let label:UILabel = UILabel(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.frame.width, height: CGFloat.greatestFiniteMagnitude)))
		label.numberOfLines = 0
		label.lineBreakMode = NSLineBreakMode.byWordWrapping
		label.font = self.font
		label.text = self.text
		label.sizeToFit()
		return label.frame.height
	}
}
