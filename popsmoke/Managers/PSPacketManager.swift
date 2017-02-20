//
//  PSUserManager.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/28/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum PacketError: Error {
	case fileError
	case createError
}

class PSPacketManager {
	
	static let sharedInstance = PSPacketManager()
		
	private(set) var packet = PSPacket()
	private(set) var completedPackets = [PSPacket]()
	private(set) var completedPacketFiePaths = [String]()
	private(set) var reloadCurrentPacket = Variable( false )
	
	init() {
		beginPacketBuilding()
	}
	
	// MARK: - Packet Builder
	
	func beginPacketBuilding() {
		do {
			try packet = PSPacketFactory.createDA31()
			reloadCurrentPacket.value = true
			reloadCurrentPacket.value = false
		} catch PersistenceError.packetPersistence {
			PSErrorHandler.presentErrorWith(title: "Whoops!", message: "We had a problem loading the Packet!")
		} catch {
			PSErrorHandler.presentErrorWith(title: "Whoops!", message: "We messed up building our packet.")
		}
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

extension PSPacketManager: PSPermissions {
	
	func allowedToCreatePacket() -> Bool {
		return (PSUserManager().allowedToCreatePacket() && PSPurchaseManager().allowedToCreatePacket() )
	}
}
