//
//  PSPersistenceManager.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/26/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

class PSPersistenceManager: NSObject {

	private class func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		let documentsDirectory = paths[0]
		return documentsDirectory
	}
	
/**---------------------------------------------------------------------------------------
 * @name Creating New File Names
 * ---------------------------------------------------------------------------------------
 */
	
	class func save(image: UIImage, fileName: String) {
		guard let data = UIImagePNGRepresentation(image) else {
			//TODO: Handle the errors in a global error alert
			return
		}
		let filePath = getDocumentsDirectory().appendingPathComponent("\(fileName)")
		do {
			try? data.write(to: filePath)
			return
		}
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
