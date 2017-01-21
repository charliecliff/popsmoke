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

class DA31PDFFiller: NSObject {

	let document = ILPDFDocument(resource:"DA_31")

	func fillPDFQithFormData(dictionary: [String: Any?]) {
		
		if let controlNumber = dictionary[da31_control_number] as? Int {
			document.forms!.setValue(String(controlNumber), forFormWithName: da31_pdf_control_number)
		}
		if let ssn = dictionary[personal_info_ssn] as? Int {
			document.forms!.setValue(String(ssn), forFormWithName: da31_pdf_ssn)
		}
		if let date = dictionary[da31_date] as? Date {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "yyyy-MM-dd"
			let dateString = dateFormatter.string(from: date)
			document.forms!.setValue(dateString, forFormWithName: da31_pdf_date)
		}
		let firstName = dictionary[personal_info_first_name] as? String
		let middleInitial = dictionary[personal_info_middle_initial] as? String
		let lastName = dictionary[personal_info_last_name] as? String
		if firstName != nil  && lastName != nil && middleInitial != nil {
			let fullName = DA31PDFFiller.fullNameFrom(firstName: firstName!, middleInitial: middleInitial!, lastName: lastName!)
			document.forms!.setValue(fullName, forFormWithName: da31_pdf_name)
		}
		let street = dictionary[address_street] as? String
		let city = dictionary[address_city] as? String
		let state = dictionary[address_state] as? String
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
			dateFormatter.dateFormat = "yyyy-MM-dd"
			let dateString = dateFormatter.string(from: date)
			document.forms!.setValue(dateString, forFormWithName: da31_pdf_date_from)
		}
		if let date = dictionary[da31_leave_date_to] as? Date {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "yyyy-MM-dd"
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
	}
	
	class func fullNameFrom(firstName:String, middleInitial: String, lastName: String) -> String {
		
		return "\(lastName), \(firstName) \(middleInitial)."
	}
	
	class func addressFrom(street:String, city: String, state: String, zip: String, phoneNumber: String) -> String {
		
		return "\(street), \(city) \(state), \(zip), \(phoneNumber)"
	}
	
	class func stationFrom(station:String, orgn: String, phone: String) -> String {
		
		return "\(station), \(orgn) \(phone)"
	}
}
