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

fileprivate let da31_pdf_date_format	= "yyyy/mm/dd"

class DA31PDFFiller: NSObject {

	class func fillPDFWithFormData(dictionary: [String: Any?]) -> ILPDFDocument? {
		
		// Generate PDF Form
		guard let path = PSPacketUtilities.copyPDF(pdfName: "DA_31") else {
			return nil
		}
		let document = ILPDFDocument(path: path)

		// Fill out the PDF
		// Block 1 - This sould be left blank
		if let controlNumber = dictionary[da31_control_number] as? Int {
			document.forms!.setValue(String(controlNumber), forFormWithName: da31_pdf_control_number)
		}
		// Block 2
		let firstName = dictionary[personal_info_first_name] as? String
		let middleInitial = dictionary[personal_info_middle_initial] as? String
		let lastName = dictionary[personal_info_last_name] as? String
		if firstName != nil  && lastName != nil && middleInitial != nil {
			let fullName = DA31PDFFiller.fullNameFrom(firstName: firstName!, middleInitial: middleInitial!, lastName: lastName!)
			document.forms!.setValue(fullName, forFormWithName: da31_pdf_name)
		}
		// Block 3
		if let ssn = dictionary[personal_info_ssn] as? Int {
			document.forms!.setValue("xxx-xx-\(String(ssn))", forFormWithName: da31_pdf_ssn)
		}
		if let date = dictionary[da31_date] as? Date {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = da31_pdf_date_format
			let dateString = dateFormatter.string(from: date)
			document.forms!.setValue(dateString, forFormWithName: da31_pdf_date)
		}
		// Block 6 - Leave Address
		let street = dictionary[address_street] as? String
		let city = dictionary[address_city] as? String
		let state = dictionary[address_state] as? USState
		let zip = dictionary[address_zip] as? String
		let phone = dictionary[personal_info_phone] as? String
		if street != nil  && city != nil && state != nil && zip != nil && phone != nil {
			let address = DA31PDFFiller.addressFrom(street: street!, city: city!, state: state!, zip: zip!, phoneNumber: phone!)
			document.forms!.setValue(address, forFormWithName: da31_pdf_address)
		}
		let stationOrgn = dictionary[da31_station_orgn] as? String
		let station = dictionary[da31_station] as? String
		let stationPhone = dictionary[da31_station_phone] as? String
		if stationOrgn != nil  && station != nil && stationPhone != nil {
			let address = DA31PDFFiller.stationFrom(station: station!, orgn: stationOrgn!, phone: stationPhone!)
			document.forms!.setValue(address, forFormWithName: da31_pdf_station)
		}
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
		if let rank = dictionary[personal_info_rank] as? String {
			document.forms!.setValue(rank, forFormWithName: da31_pdf_rank)
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
		return "\(street)\n\(city), \(state.rawValue)\n\(formatedPhoneNumber)"
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
