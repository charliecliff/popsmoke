//
//  PSProfileViewController.swift
//  popsmoke
//
//  Created by Charles Cliff on 2/13/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

fileprivate let profile_option_cell		= "option_cell"
fileprivate let profile_disclosure_cell = "disclosure_cell"

fileprivate let licenseSection			= 0
fileprivate let profileOptionsSection	= 1
fileprivate let personalInfoSection		= 2

fileprivate let pushNotificationRow		= 0
fileprivate let autofillRow				= 1

fileprivate let personalInfoRow			= 0
fileprivate let postingRow				= 1

class PSProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	@IBOutlet public var tableView: UITableView?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		let optionNib = UINib(nibName: "PSOptionTableViewCell", bundle:nil)
		self.tableView?.register(optionNib, forCellReuseIdentifier: profile_option_cell)
		let disclosureNib = UINib(nibName: "PSDisclosureTableViewCell", bundle:nil)
		self.tableView?.register(disclosureNib, forCellReuseIdentifier: profile_disclosure_cell)
	}
	
	// MARK: - UITableViewDataSource
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 3
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == profileOptionsSection {
			return 2
		} else if section == personalInfoSection {
			return 1
		} else if section == licenseSection {
			return 1
		}
		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == profileOptionsSection {
			guard let cell = tableView.dequeueReusableCell(withIdentifier:profile_option_cell , for: indexPath) as? PSOptionTableViewCell else {
				return UITableViewCell()
			}
			if indexPath.row == pushNotificationRow {
				cell.textLabel?.text = "ENABLE REMINDERS"
			} else if indexPath.row == autofillRow {
				cell.textLabel?.text = "ENABLE AUTOFILL"
			}
			return cell
		} else if indexPath.section == personalInfoSection {
			guard let cell = tableView.dequeueReusableCell(withIdentifier:profile_disclosure_cell , for: indexPath) as? PSDisclosureTableViewCell else {
				return UITableViewCell()
			}
			if indexPath.row == personalInfoRow {
				cell.textLabel?.text = "PERSONAL INFO"
			} else if indexPath.row == postingRow {
				cell.textLabel?.text = "POST"
			}
			return cell
		} else if indexPath.section == licenseSection {
			return UITableViewCell()
		}
		return UITableViewCell()
	}
	
	// MARK: - UITableViewDelegate
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.section == profileOptionsSection {
			if indexPath.row == pushNotificationRow {
				
			} else if indexPath.row == autofillRow {
				
			}
		} else if indexPath.section == personalInfoSection {
			if indexPath.row == personalInfoRow {
				
			}
		} else if indexPath.section == licenseSection {
			// TODO: Display the Purchase Screen
		}
	}
}
