//
//  PSUserManager.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/28/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PSUserManager {
	
	static let sharedInstance = PSUserManager()
	
	private(set) var packet: PSPacket?
	private(set) var completedPackets = [PSPacket]()
	
	private(set) var completedPacketFiePaths = [String]()
	
	
	
	private(set) var reloadCurrentPacket = Variable( false )
	
	
	
	init() {
		
		beginPacketBuilding()
	}
	
	// MARK: - Packet Builder
	
	func beginPacketBuilding() {
		
		packet = PSPacketFactory.createDA31()
	}

	func savePacket(packet: PSPacket) {
		
		PSPersistenceManager.save(packet: packet)
		completedPackets.append(packet)
		beginPacketBuilding()
		reloadCurrentPacket.value = true
		reloadCurrentPacket.value = false
	}
	
	func deletePacket(packet: PSPacket) {
		
	}
}
