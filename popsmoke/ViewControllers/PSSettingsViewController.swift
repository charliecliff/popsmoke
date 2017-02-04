//
//  PSSettingsViewController.swift
//  popsmoke
//
//  Created by Charles Cliff on 2/2/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

class PSSettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
    }
	
	// MARK: - Actions
	
	@IBAction func didPressLogoutButton(sender: UIButton) {
		PSUserManager.sharedInstance.logout()
	}
}
