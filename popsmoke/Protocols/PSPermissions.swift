//
//  PSPermissions.swift
//  popsmoke
//
//  Created by Charles Cliff on 2/15/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

protocol PSPermissions: class {
	func allowedToCreatePacket() -> Bool
}
