//
//  DA31PDFFiller.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/19/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit
import ILPDFKit

let da31_pdf_control_number		= "Control Number"
let da31_pdf_name				= "Name"
let da31_pdf_rank				= "Rank"
let da31_pdf_ssn				= "SSN"
let da31_pdf_date				= "Date"
let da31_pdf_address			= "Address"
let da31_pdf_station			= "ORGN"

let da31_pdf_leave_ordinary		= "Ordinary"
let da31_pdf_leave_emergency	= "Emergency"
let da31_pdf_leave_permissive	= "Permissive"
let da31_pdf_leave_other		= "Other"
let da31_pdf_accrued_leave		= "Accrued"
let da31_pdf_advanced_leave		= "Advanced"
let da31_pdf_excess_leave		= "Excess"
let da31_pdf_requested_leave	= "Requested"
let da31_pdf_date_to			= "Date-To"
let da31_pdf_date_from			= "Date-From"

fileprivate let da31_pdf_date_format	= "yyyy/MM/dd"

class DA31PDFFiller: NSObject {

	class func fillPDFWithFormData(dictionary: [String: Any?]) -> ILPDFDocument? {
		
		// Generate PDF Form
		guard let path = PSPacketUtilities.copyPDF(pdfName: "DA_31") else {
			return nil
		}
		let document = ILPDFDocument(path: path)
		
		// Fill out the PDF
		// Block 1 - BLANK
		// Block 2 - Name
		let firstName = dictionary[personal_info_first_name] as? String
		let middleInitial = dictionary[personal_info_middle_initial] as? String
		let lastName = dictionary[personal_info_last_name] as? String
		if firstName != nil  && lastName != nil && middleInitial != nil {
			let fullName = DA31PDFFiller.fullNameFrom(firstName: firstName!, middleInitial: middleInitial!, lastName: lastName!)
			document.forms!.setValue(fullName, forFormWithName: da31_pdf_name)
		}
		// Block 3 -  Last 4 Digits of SSN
		if let ssn = dictionary[personal_info_ssn] as? Int {
			document.forms!.setValue("xxx-xx-\(String(ssn))", forFormWithName: da31_pdf_ssn)
		}
		// Block 4 - Rank
		if let rank = dictionary[personal_info_rank] as? USArmyRank {
			document.forms!.setValue(rank.rawValue, forFormWithName: da31_pdf_rank)
		}
		// Block 5 - Current Date
		let currentDate = Date()
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = da31_pdf_date_format
		let dateString = dateFormatter.string(from: currentDate)
		document.forms!.setValue(dateString, forFormWithName: da31_pdf_date)
		// Block 6 - Leave Address
		let street = dictionary[address_street] as? String
		let city = dictionary[address_city] as? String
		let state = dictionary[address_state] as? USState
		let zip = dictionary[address_zip] as? String
		let phone = dictionary[personal_info_phone] as? String
		if street != nil  && city != nil && state != nil && phone != nil && zip != nil {
			let address = DA31PDFFiller.addressFrom(street: street!, city: city!, state: state!, zip: zip!, phoneNumber: phone!)
			document.forms!.setValue(address, forFormWithName: da31_pdf_address)
		}
		// Block 7 - Leave Type
		if let leaveType = dictionary[da31_leave_type] as? String {
			if leaveType == da31_leave_type_ordinary {
				document.forms!.setValue("Yes", forFormWithName: da31_pdf_leave_ordinary)
				
			}
			if leaveType == da31_leave_type_emergency {
				document.forms!.setValue("Yes", forFormWithName: da31_pdf_leave_emergency)
			}
			if leaveType == da31_leave_type_permissive {
				document.forms!.setValue("Yes", forFormWithName: da31_pdf_leave_permissive)
			}
			if leaveType == da31_leave_type_other {
				document.forms!.setValue("Yes", forFormWithName: da31_pdf_leave_other)
			}
		}
		// Block 8
		var stationString = ""
		let platoon = dictionary[da31_station_platoon] as? String
		let company = dictionary[da31_station_company] as? String
		let battalion = dictionary[da31_station_battalion] as? String
		if platoon != nil && company != nil && battalion != nil {
			stationString = "\(stationString)\(platoon!), \(company!), \(battalion!)"
		}
		
		let brigade = dictionary[da31_station_brigade] as? String
		let division = dictionary[da31_station_division] as? String
		if brigade != nil && division != nil {
			stationString = "\(stationString)\n\(brigade!), \(division!)"
		}
		
		let post = dictionary[da31_station_post] as? String
		let postZip = dictionary[da31_station_zip] as? String
		let stationPhone = dictionary[da31_station_phone] as? String
		if post != nil && postZip != nil && stationPhone != nil {
			stationString = "\(stationString)\n\(post!) \(postZip!), \(stationPhone!)"
		}
		document.forms!.setValue(stationString, forFormWithName: da31_pdf_station)
		
		// Block 9
		if let accruedLeave = dictionary[da31_accrued_leave] as? Int {
			document.forms!.setValue(String(accruedLeave), forFormWithName: da31_pdf_accrued_leave)
		} else {
			document.forms!.setValue("0", forFormWithName: da31_pdf_accrued_leave)
		}
		if let requestedLeave = dictionary[da31_requested_leave] as? Int {
			document.forms!.setValue(String(requestedLeave), forFormWithName: da31_pdf_requested_leave)
		} else {
			document.forms!.setValue("0", forFormWithName: da31_pdf_requested_leave)
		}
		if let advancedLeave = dictionary[da31_advanced_leave] as? Int {
			document.forms!.setValue(String(advancedLeave), forFormWithName: da31_pdf_advanced_leave)
		} else {
			document.forms!.setValue("0", forFormWithName: da31_pdf_advanced_leave)
		}
		if let excessLeave = dictionary[da31_excess_leave] as? Int {
			document.forms!.setValue(String(excessLeave), forFormWithName: da31_pdf_excess_leave)
		} else {
			document.forms!.setValue("0", forFormWithName: da31_pdf_excess_leave)
		}
		// Block 10
		if let date = dictionary[da31_leave_date_from] as? Date {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = da31_pdf_date_format
			let dateString = dateFormatter.string(from: date)
			document.forms!.setValue(dateString, forFormWithName: da31_pdf_date_from)
		}
		if let date = dictionary[da31_leave_date_to] as? Date {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = da31_pdf_date_format
			let dateString = dateFormatter.string(from: date)
			document.forms!.setValue(dateString, forFormWithName: da31_pdf_date_to)
		}
		// Return PDF Form
		let data = document.savedStaticPDFData()
		let savedVCDocument = ILPDFDocument(data: data)
		return savedVCDocument
	}
	
	class func fullNameFrom(firstName:String, middleInitial: String, lastName: String) -> String {
		return "\(lastName), \(firstName) \(middleInitial)."
	}

	class func formattedPhonNumber(phoneNumber: String) -> String {
		var start = phoneNumber.index(phoneNumber.startIndex, offsetBy: 0)
		var end = phoneNumber.index(phoneNumber.startIndex, offsetBy: 3)
		var range = Range(uncheckedBounds: (lower: start, upper: end))
		let areaCode = phoneNumber.substring(with: range)
		start = phoneNumber.index(phoneNumber.startIndex, offsetBy: 3)
		end = phoneNumber.index(phoneNumber.startIndex, offsetBy: 6)
		range = Range(uncheckedBounds: (lower: start, upper: end))
		let firstThreeDigits = phoneNumber.substring(with: range)
		start = phoneNumber.index(phoneNumber.startIndex, offsetBy: 6)
		end = phoneNumber.index(phoneNumber.startIndex, offsetBy: 10)
		range = Range(uncheckedBounds: (lower: start, upper: end))
		let lastFourDigits = phoneNumber.substring(with: range)
		return "(\(areaCode)) \(firstThreeDigits)-\(lastFourDigits)"
	}
	
	
	class func addressFrom(street:String, city: String, state: USState, zip: String, phoneNumber: String) -> String {
		let formatedPhoneNumber = DA31PDFFiller.formattedPhonNumber(phoneNumber: phoneNumber)
		return "\(street)\n\(city), \(state.rawValue) \(zip)\n\(formatedPhoneNumber)"
	}
	
	class func stationFrom(station:String, orgn: String, phone: String) -> String {
		return "\(station), \(orgn) \(phone)"
	}
	
	class func createNewPDFFile() -> String? {
	
		let path = Bundle.main.path(forResource: "DA_31", ofType: "pdf")
		guard let doumentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as String? else {
			return nil
		}
		guard let uuid = CFUUIDCreateString(nil, CFUUIDCreate(nil)) else {
			return nil
		}
		guard let  destinationPath = doumentDirectoryPath.appending("/\(uuid).pdf") as String? else {
			return nil
		}
		do {
			try FileManager.default.copyItem(atPath:path!, toPath:destinationPath)
			return destinationPath
		}
		catch let error as NSError {
			print("Ooops! Something went wrong: \(error)")
			assert(false)
		}
		return nil
	}
}
