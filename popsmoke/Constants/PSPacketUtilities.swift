//
//  PSPacketUtilities.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/24/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import Foundation

enum PacketType: String {
	case error	= "ERROR"
	case leave	= "Leave"
}

enum DocumentType: String {
	case error		= "ERROR"
	case form		= "form"
	case attachment	= "attachment"
	case web		= "web"
}

enum FormType: String {
	case error			= "ERROR"
	case da31			= "da31"
	case trips			= "trips"
	case personalInfo	= "personal_info"
}

enum AttachmentType: String {
	case error				= "ERROR"
	case drivers_license	= "drivers_license"
	case insurance			= "insurance"
}

class PSPacketUtilities: NSObject {

	class func copyPDF(pdfName: String) -> String? {
		guard let url = Bundle.main.url(forResource: pdfName, withExtension: "pdf", subdirectory: nil, localization: nil) else {
			PSErrorHandler.presentErrorWith(title: "Whoops!", message: "We weren't able to read the PDF File")
			return nil
		}
		guard let uuid = CFUUIDCreateString(nil, CFUUIDCreate(nil)) else {
			PSErrorHandler.presentErrorWith(title: "Whoops!", message: "We weren't able to create a randomized UID")
			return nil
		}
		let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as String
		let url1 = NSURL(fileURLWithPath: path)
		let destinationPath = url1.appendingPathComponent("\(uuid).pdf")?.path
		do {
			try FileManager.default.copyItem(atPath: url.path, toPath: destinationPath!)
		}
		catch let error as NSError {
			PSErrorHandler.presentError(error: error)
		}
		return destinationPath
	}
	
	class func newPDFFilePath() -> String? {
		guard let uuid = CFUUIDCreateString(nil, CFUUIDCreate(nil)) else {
			return nil
		}
		let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as String
		let url = NSURL(fileURLWithPath: path)
		let filePath = url.appendingPathComponent("\(uuid).pdf")?.path
		return filePath
	}
	
	class func normalIconFileFrom(iconName: String) -> UIImage? {
		return UIImage.init(named: iconName)
	}
	
	class func hightedIconFileFrom(iconName: String) -> UIImage? {
		return UIImage.init(named: "\(iconName)_complete")

	}
}
