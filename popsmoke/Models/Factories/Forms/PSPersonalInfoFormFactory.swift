//
//  PSPersonalInfoFormFactory.swift
//  popsmoke
//
//  Created by Charles Cliff on 2/1/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import Eureka

let personal_info_section_title		= "PERSONAL INFORMATION"
let personal_info_first_name		= "FIRST NAME"
let personal_info_last_name			= "LAST NAME"
let personal_info_middle_initial	= "MIDDLE INITIAL"
let personal_info_ssn				= "SSN"
let personal_info_rank				= "RANK"
let personal_info_phone				= "PHONE"

fileprivate let first_name_placeholder_text		= "Enter First Name"
fileprivate let middle_initial_placeholder_text = "Middle Initial"
fileprivate let last_name_placeholder_text		= "Enter Last Name"
fileprivate let ssn_placeholder_text			= "Last 4 Digits"

class PSPersonalInfoFormFactory: NSObject {

	class func appendPersonalInformationToForm(form: Form) {
		
		form +++ Section(personal_info_section_title)
			<<< TextRow(){ row in
				row.tag = personal_info_first_name
				row.title = personal_info_first_name
				row.placeholder = first_name_placeholder_text
				row.add(rule: RuleRequired())
				}.cellSetup { cell, row in
					cell.backgroundColor = form_row_background
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
			}
			<<< TextRow(){ row in
				row.tag = personal_info_middle_initial
				row.title = personal_info_middle_initial
				row.placeholder = middle_initial_placeholder_text
				row.add(rule: RuleRequired())
				}.cellSetup { cell, row in
					cell.backgroundColor = form_row_background
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
			}
			<<< TextRow(){ row in
				row.tag = personal_info_last_name
				row.title = personal_info_last_name
				row.placeholder = last_name_placeholder_text
				row.add(rule: RuleRequired())
				}.cellSetup { cell, row in
					cell.backgroundColor = form_row_background
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
			}
			<<< IntRow(){ row in
				row.tag = personal_info_ssn
				row.title = personal_info_ssn
				row.placeholder = ssn_placeholder_text
				row.add(rule: RuleRequired())
				row.add(rule: RuleSmallerOrEqualThan(max: 9999))
				row.add(rule: RuleGreaterOrEqualThan(min: 0000))
				}.cellSetup { cell, row in
					cell.backgroundColor = form_row_background
				}.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
			}
			<<< PickerInlineRow<String>() { (row : PickerInlineRow<String>) -> Void in
				row.tag = personal_info_rank
				row.title = personal_info_rank
				row.options = PSPersonalInfoUtilities.ranks()
				row.value = row.options.first
				row.add(rule: RuleRequired())
				let nonErrRule = RuleClosure.init(closure: { (rowValue) -> ValidationError? in
					return (USArmyRank(rawValue: rowValue!) == USArmyRank.ERR) ? ValidationError(msg: "Field required!") : nil
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
}
