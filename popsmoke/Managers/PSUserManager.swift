//
//  PSUserManager.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/28/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

class PSUserManager {
	
	static let sharedInstance = PSUserManager()
	
	private(set) var packet: PSPacket?
	private(set) var completedPackets = [PSPacket]()
	
	private(set) var completedPacketFiePaths = [String]()

	init() {
		
		beginPacketBuilding()
	}
	
	// MARK: - Packet Builder
	
	func beginPacketBuilding() {
		
		packet = PSPacketFactory.createDA31()
	}

	func savePacket(packet: PSPacket) {
		
		
		
		
	}
	
	func deletePacket(packet: PSPacket) {
		
	}
}
