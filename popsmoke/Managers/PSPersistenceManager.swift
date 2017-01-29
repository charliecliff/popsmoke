//
//  PSPersistenceManager.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/26/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit
import ILPDFKit

enum PersistenceError: Error {
	case packetPersistence
	case imagePersistence
}

class PSPersistenceManager: NSObject {

	private class func getDocumentURL(packetID: String) -> String {
		var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as String
		path.append(packetID)
		return path
	}
	
	private class func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		let documentsDirectory = paths[0]
		return documentsDirectory
	}
	
/**---------------------------------------------------------------------------------------
 * @name Saving Objects
 * ---------------------------------------------------------------------------------------
 */
	class func save(packet: PSPacket) {
		let filePath = PSPersistenceManager.getDocumentURL(packetID: packet.packetID!)
		NSKeyedArchiver.archiveRootObject(packet, toFile: filePath)
	}
	
	class func save(image: UIImage, fileName: String) throws {
		guard let data = UIImagePNGRepresentation(image) else {
			throw PersistenceError.imagePersistence
		}
		FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
	}

/**---------------------------------------------------------------------------------------
 * @name Loading Objects
 * ---------------------------------------------------------------------------------------
 */
	class func loadPacket(filePath: String) throws -> PSPacket? {
		guard let packet = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? PSPacket else {
			throw PersistenceError.packetPersistence
		}
		return packet
	}
	
/**---------------------------------------------------------------------------------------
 * @name Creating New File Names
 * ---------------------------------------------------------------------------------------
 */
	
/** Returns the number of pages in the document.
 
 @return PNG File Name.
 */
	class func newPNGFilePath() -> String? {
		guard let doumentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as String? else {
			return nil
		}
		guard let uuid = CFUUIDCreateString(nil, CFUUIDCreate(nil)) else {
			return nil
		}
		guard let destinationPath = doumentDirectoryPath.appending("/\(uuid).png") as String? else {
			return nil
		}
		return destinationPath
	}
	
/** Returns the number of pages in the document.
 
 @return PDF File Name.
 */
	class func newPDFFilePath() -> String? {
		guard let doumentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as String? else {
			return nil
		}
		guard let uuid = CFUUIDCreateString(nil, CFUUIDCreate(nil)) else {
			return nil
		}
		guard let destinationPath = doumentDirectoryPath.appending("/\(uuid).pdf") as String? else {
			return nil
		}
		return destinationPath
	}
}
