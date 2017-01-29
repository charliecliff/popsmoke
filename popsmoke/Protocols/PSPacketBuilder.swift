//
//  PSPacketBuilder.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/29/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import Foundation

protocol PSPacketBuilder: class {
	
	var someTypeProperty: PSPacket { get }

	func beginPacketBuilding()
	func savePacket()
}
