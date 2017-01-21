//
//  DA31FormFactory.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/19/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import Eureka

let da31_control_number		= "CONTROL NUMBER"
let da31_date				= "DATE"
let da31_leave_type			= "LEAVE TYPE"

let personal_info_first_name		= "FIRST NAME"
let personal_info_last_name			= "LAST NAME"
let personal_info_middle_initial	= "MIDDLE INITIAL"
let personal_info_ssn				= "SSN"
let personal_info_rank				= "RANK"
let personal_info_phone				= "PHONE"

let address_street			= "STREET"
let address_city			= "CITY"
let address_state			= "STATE"
let address_zip				= "ZIP"

let da31_station_orgn		= "ORGN"
let da31_station			= "STATION"
let da31_station_phone		= "PHONE NO."

let da31_accrued_leave		= "ACCRUED"
let da31_requested_leave	= "REQUESTED"
let da31_advanced_leave		= "ADVANCED"
let da31_excess_leave		= "EXCESS"
let da31_leave_date_from	= "FROM"
let da31_leave_date_to		= "TO"

let da31_leave_type_ordinary	= "ORDINARY"
let da31_leave_type_emergency	= "EMERGENCY"
let da31_leave_type_permissive	= "PERMISSIVE TDY"
let da31_leave_type_other		= "OTHER"

class DA31FormFactory: NSObject {

	class func appendLeaveDetailsToForm(form: Form) {
		
		form +++ Section()
			<<<	IntRow(){ row in
				row.tag = da31_control_number
				row.title = da31_control_number
				row.placeholder = "Enter control number here"
			}
			<<< DateRow(){ row in
				row.tag = da31_date
				row.title = da31_date
				row.value = Date(timeIntervalSinceReferenceDate: 0)
			}
			<<< AlertRow<String>() { row in
				row.tag = da31_leave_type
				row.title = da31_leave_type
				row.selectorTitle = "Please Select Type of Leave"
				row.options = DA31FormFactory.leaveTypes()
				row.value = DA31FormFactory.leaveTypes()[0]
				}.onChange { row in
					print(row.value ?? "No Value")
				}
				.onPresent{ _, to in
					to.view.tintColor = .purple
		}
	}
	
	class func appendPersonalInformationToForm(form: Form) {
		
		form +++ Section("PERSONAL INFORMATION")
			<<< TextRow(){ row in
				row.tag = personal_info_first_name
				row.title = personal_info_first_name
				row.placeholder = "Enter text here"
				row.add(rule: RuleMinLength(minLength: 10))
				row.validationOptions = .validatesOnChangeAfterBlurred
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
			<<< TextRow(){ row in
				row.tag = personal_info_middle_initial
				row.title = personal_info_middle_initial
				row.placeholder = "Enter text here"
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
			<<< TextRow(){ row in
				row.tag = personal_info_last_name
				row.title = personal_info_last_name
				row.placeholder = "Enter text here"
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
			<<< IntRow(){ row in
				row.tag = personal_info_ssn
				row.title = personal_info_ssn
				row.placeholder = "Enter text here"
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
			<<< TextRow(){ row in // TODO: Custom Rank Row
				row.tag = personal_info_rank
				row.title = personal_info_rank
				row.placeholder = "Enter text here"
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
	}
	
	class func appendAddressToForm(form: Form) {
		
		form +++ Section("ADDRESS")
			<<< TextRow() { row in
				row.tag = address_street
				row.title = address_street
				row.placeholder = "Enter text here"
			}
			<<< TextRow() { row in
				row.tag = address_city
				row.title = address_city
				row.placeholder = "Enter text here"
			}
			<<< TextRow() { row in
				row.tag = address_state
				row.title = address_state
				row.placeholder = "Enter text here"
			}
			<<< ZipCodeRow() { row in
				row.tag = address_zip
				row.title = address_zip
				row.placeholder = "Enter text here"
			}
			<<< PhoneRow() { row in
				row.tag = personal_info_phone
				row.title = personal_info_phone
				row.placeholder = "And numbers here"
		}
	}
	
	class func appendStationToForm(form: Form) {
		
		form +++ Section("STATION INFORMATION")
			<<< TextRow() { row in
				row.tag = da31_station_orgn
				row.title = da31_station_orgn
				row.placeholder = "Enter text here"
			}
			<<< TextRow() { row in
				row.tag = da31_station
				row.title = da31_station
				row.placeholder = "Enter text here"
			}
			<<< PhoneRow() { row in
				row.tag = da31_station_phone
				row.title = da31_station_phone
				row.placeholder = "And numbers here"
		}
	}
	
	class func appendLeaveDaysToForm(form: Form) {
		
		form +++ Section("NUMBER OF DAYS LEAVE")
			<<< IntRow() { row in
				row.tag = da31_accrued_leave
				row.title = da31_accrued_leave
			}
			<<< IntRow() { row in
				row.tag = da31_requested_leave
				row.title = da31_requested_leave
			}
			<<< IntRow() { row in
				row.tag = da31_advanced_leave
				row.title = da31_advanced_leave
			}
			<<< IntRow() { row in
				row.tag = da31_excess_leave
				row.title = da31_excess_leave
		}
	}
	
	class func appendLeaveDatesToForm(form: Form) {
		
		form +++ Section("LEAVE DATES")
			<<< DateRow() { row in
				row.tag = da31_leave_date_from
				row.title = da31_leave_date_from
			}
			<<< DateRow() { row in
				row.tag = da31_leave_date_to
				row.title = da31_leave_date_to
		}
	}
	
	class func toDictionary(form: Form) -> [String: Any?] {
		
		return form.values()
	}
	
	class func leaveTypes() -> [String] {
		
		return [da31_leave_type_ordinary, da31_leave_type_emergency, da31_leave_type_permissive, da31_leave_type_other]
	}
}
