//
//  DA31FormFactory.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/19/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import Eureka


let address_street					= "STREET"
let address_city					= "CITY"
let address_state					= "STATE"
let address_zip						= "ZIP"

let da31_control_number			= "CONTROL NUMBER"
let da31_date					= "DATE"
let da31_leave_type				= "LEAVE TYPE"
let da31_station_orgn			= "ORGN"
let da31_station				= "STATION"
let da31_station_phone			= "PHONE NO."
let da31_accrued_leave			= "ACCRUED"
let da31_requested_leave		= "REQUESTED"
let da31_advanced_leave			= "ADVANCED"
let da31_excess_leave			= "EXCESS"
let da31_leave_date_from		= "FROM"
let da31_leave_date_to			= "TO"
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
					row.add(rule: RuleRequired())
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
			<<< DateRow(){ row in
					row.tag = da31_date
					row.title = da31_date
					row.value = Date(timeIntervalSinceReferenceDate: 0)
					row.add(rule: RuleRequired())
				// TODO: Change the color of Date Rows during verification
					row.cell.textLabel?.textColor = .blue
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.textLabel?.textColor = .red
//						cell.titleLabel?.textColor = .red
					}
				}
			<<< AlertRow<String>() { row in
					row.tag = da31_leave_type
					row.title = da31_leave_type
					row.selectorTitle = "Please Select Type of Leave"
					row.options = DA31FormFactory.leaveTypes()
					row.value = DA31FormFactory.leaveTypes()[0]
					row.add(rule: RuleRequired())
				}.onChange { row in
					print(row.value ?? "No Value")
				}.onPresent{ _, to in
					to.view.tintColor = .purple
				}.cellUpdate { cell, row in
					if !row.isValid {
						
					}
				}
	}
	
	class func appendAddressToForm(form: Form) {
		
		form +++ Section("ADDRESS")
			<<< TextRow() { row in
					row.tag = address_street
					row.title = address_street
					row.placeholder = "Enter text here"
					row.add(rule: RuleRequired())
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
			<<< TextRow() { row in
					row.tag = address_city
					row.title = address_city
					row.placeholder = "Enter text here"
					row.add(rule: RuleRequired())
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
			<<< PickerInlineRow<USState>() { (row : PickerInlineRow<USState>) -> Void in
					row.tag = address_state
					row.title = address_state
					row.options = PSAddressUtilities.states()
					row.value = row.options.first
				}
			<<< ZipCodeRow() { row in
					row.tag = address_zip
					row.title = address_zip
					row.placeholder = "Enter text here"
					row.add(rule: RuleRequired())
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
			<<< PhoneRow() { row in
					row.tag = personal_info_phone
					row.title = personal_info_phone
					row.placeholder = "And numbers here"
					row.add(rule: RuleRequired())
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
	}
	
	class func appendStationToForm(form: Form) {
		
		form +++ Section("STATION INFORMATION")
			<<< TextRow() { row in
					row.tag = da31_station_orgn
					row.title = da31_station_orgn
					row.placeholder = "Enter text here"
					row.add(rule: RuleRequired())
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
			<<< TextRow() { row in
					row.tag = da31_station
					row.title = da31_station
					row.placeholder = "Enter text here"
					row.add(rule: RuleRequired())
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
			<<< PhoneRow() { row in
					row.tag = da31_station_phone
					row.title = da31_station_phone
					row.placeholder = "And numbers here"
					row.add(rule: RuleRequired())
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
	}
	
	class func appendLeaveDaysToForm(form: Form) {
		
		form +++ Section("NUMBER OF DAYS LEAVE")
			<<< IntRow() { row in
					row.tag = da31_accrued_leave
					row.title = da31_accrued_leave
					row.add(rule: RuleRequired())
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
			<<< IntRow() { row in
					row.tag = da31_requested_leave
					row.title = da31_requested_leave
					row.add(rule: RuleRequired())
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
			<<< IntRow() { row in
					row.tag = da31_advanced_leave
					row.title = da31_advanced_leave
					row.add(rule: RuleRequired())
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
			<<< IntRow() { row in
					row.tag = da31_excess_leave
					row.title = da31_excess_leave
					row.add(rule: RuleRequired())
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
	}
	
	class func appendLeaveDatesToForm(form: Form) {
		
		form +++ Section("LEAVE DATES")
			<<< DateRow() { row in
					row.tag = da31_leave_date_from
					row.title = da31_leave_date_from
					row.add(rule: RuleRequired())
				}.cellUpdate { cell, row in
					if !row.isValid {
						
					}
				}
			<<< DateRow() { row in
					row.tag = da31_leave_date_to
					row.title = da31_leave_date_to
					row.add(rule: RuleRequired())
				}.cellUpdate { cell, row in
					if !row.isValid {
						
					}
				}
	}
	
	class func toDictionary(form: Form) -> [String: Any?] {
		
		return form.values()
	}
	
	class func leaveTypes() -> [String] {
		
		return [da31_leave_type_ordinary, da31_leave_type_emergency, da31_leave_type_permissive, da31_leave_type_other]
	}
}
