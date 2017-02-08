//
//  DA31FormFactory.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/19/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import Eureka


let address_street	= "STREET"
let address_city	= "CITY"
let address_state	= "STATE"
let address_zip		= "ZIP"

let da31_control_number			= "CONTROL NUMBER"
let da31_date					= "DATE"
let da31_leave_type				= "LEAVE TYPE"

let da31_station_platoon		= "PLATOON"
let da31_station_company		= "COMPANY"
let da31_station_battalion		= "BATTALION"
let da31_station_brigade		= "BRIGADE"
let da31_station_division		= "DIVISION"
let da31_station_post			= "POST"
let da31_station_zip			= "POSTING ZIP"
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
let da31_leave_type_other		= "OTHER / PASS"

enum DA31LeaveType: String {
	case ERR		= "   "
	case OTHER		= "OTHER / PASS"
	case ORDINARY	= "ORDINARY"
	case EMERGENCY	= "EMERGENCY"
	case PERMISSIVE	= "PERMISSIVE TDY"
}

class DA31FormFactory: NSObject {

	class func appendLeaveTypeToForm(form: Form) {
		form +++ Section("LEAVE TYPE")
			<<< PickerInlineRow<String>() { (row : PickerInlineRow<String>) -> Void in
				row.tag = da31_leave_type
				row.title = da31_leave_type
				row.options = DA31FormFactory.leaveTypes()
				row.value = row.options.first
				let nonErrRule = RuleClosure.init(closure: { (rowValue) -> ValidationError? in
					return (DA31LeaveType(rawValue: rowValue!) == DA31LeaveType.ERR) ? ValidationError(msg: "Field required!") : nil
				})
				row.add(rule: nonErrRule)
				}.cellSetup { cell, row in
					cell.backgroundColor = form_row_background
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.textLabel?.textColor = .red
					}
			}
	}
	
	class func appendLeaveAddressToForm(form: Form) {
		form +++ Section("LEAVE ADDRESS")
			<<< TextRow() { row in
					row.tag = address_street
					row.title = address_street
					row.placeholder = "Enter text here"
					row.add(rule: RuleRequired())
				}.cellSetup { cell, row in
					cell.backgroundColor = form_row_background
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
				}.cellSetup { cell, row in
					cell.backgroundColor = form_row_background
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
			<<< PickerInlineRow<String>() { (row : PickerInlineRow<String>) -> Void in
					row.tag = address_state
					row.title = address_state
					row.options = PSAddressUtilities.states()
					row.value = row.options.first
					let nonErrRule = RuleClosure.init(closure: { (rowValue) -> ValidationError? in
						return (USState(rawValue: rowValue!) == USState.ERR) ? ValidationError(msg: "Field required!") : nil
					})
					row.add(rule: nonErrRule)
				}.cellSetup { cell, row in
					cell.backgroundColor = form_row_background
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.textLabel?.textColor = .red
					}
				}
			<<< ZipCodeRow() { row in
					row.tag = address_zip
					row.title = address_zip
					row.placeholder = "Enter text here"
					row.add(rule: RuleRequired())
				}.cellSetup { cell, row in
					cell.backgroundColor = form_row_background
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
				}.cellSetup { cell, row in
					cell.backgroundColor = form_row_background
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
	}
	
	class func appendStationToForm(form: Form) {
		form +++ Section("STATION INFORMATION")
			<<< TextRow() { row in
					row.tag = da31_station_platoon
					row.title = da31_station_platoon
					row.placeholder = "Enter text here"
					row.add(rule: RuleRequired())
				}.cellSetup { cell, row in
					cell.backgroundColor = form_row_background
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
			<<< TextRow() { row in
					row.tag = da31_station_company
					row.title = da31_station_company
					row.placeholder = "Enter text here"
					row.add(rule: RuleRequired())
				}.cellSetup { cell, row in
					cell.backgroundColor = form_row_background
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
			<<< TextRow() { row in
				row.tag = da31_station_battalion
				row.title = da31_station_battalion
				row.placeholder = "Enter text here"
				row.add(rule: RuleRequired())
				}.cellSetup { cell, row in
					cell.backgroundColor = form_row_background
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
			<<< TextRow() { row in
				row.tag = da31_station_brigade
				row.title = da31_station_brigade
				row.placeholder = "Enter text here"
				row.add(rule: RuleRequired())
				}.cellSetup { cell, row in
					cell.backgroundColor = form_row_background
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
			<<< TextRow() { row in
				row.tag = da31_station_division
				row.title = da31_station_division
				row.placeholder = "Enter text here"
				row.add(rule: RuleRequired())
				}.cellSetup { cell, row in
					cell.backgroundColor = form_row_background
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
			<<< TextRow() { row in
				row.tag = da31_station_post
				row.title = da31_station_post
				row.placeholder = "Enter text here"
				row.add(rule: RuleRequired())
				}.cellSetup { cell, row in
					cell.backgroundColor = form_row_background
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
			<<< ZipCodeRow() { row in
				row.tag = da31_station_zip
				row.title = da31_station_zip
				row.placeholder = "Enter text here"
				row.add(rule: RuleRequired())
				}.cellSetup { cell, row in
					cell.backgroundColor = form_row_background
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
				}.cellSetup { cell, row in
					cell.backgroundColor = form_row_background
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
					row.placeholder = "N/A"
				}.cellSetup { cell, row in
					cell.backgroundColor = form_row_background
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
			<<< IntRow() { row in
					row.tag = da31_requested_leave
					row.title = da31_requested_leave
					row.placeholder = "N/A"
				}.cellSetup { cell, row in
					cell.backgroundColor = form_row_background
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
			<<< IntRow() { row in
					row.tag = da31_advanced_leave
					row.title = da31_advanced_leave
					row.placeholder = "N/A"
				}.cellSetup { cell, row in
					cell.backgroundColor = form_row_background
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
				}
			<<< IntRow() { row in
					row.tag = da31_excess_leave
					row.title = da31_excess_leave
					row.placeholder = "N/A"
				}.cellSetup { cell, row in
					cell.backgroundColor = form_row_background
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
				}.cellSetup { cell, row in
					cell.backgroundColor = form_row_background
				}.cellUpdate { cell, row in
					if !row.isValid {
						
					}
				}
			<<< DateRow() { row in
					row.tag = da31_leave_date_to
					row.title = da31_leave_date_to
					row.add(rule: RuleRequired())
				}.cellSetup { cell, row in
					cell.backgroundColor = form_row_background
				}.cellUpdate { cell, row in
					if !row.isValid {
						
					}
				}
	}
	
	class func toDictionary(form: Form) -> [String: Any?] {
		return form.values()
	}
	
	class func leaveTypes() -> [String] {
		return [DA31LeaveType.ERR.rawValue, DA31LeaveType.OTHER.rawValue, DA31LeaveType.ORDINARY.rawValue, DA31LeaveType.EMERGENCY.rawValue, DA31LeaveType.PERMISSIVE.rawValue]
	}
}
