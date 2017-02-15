//
//  PSSettingsViewController.swift
//  popsmoke
//
//  Created by Charles Cliff on 2/2/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

class PSSettingsViewController: UIViewController {

	@IBOutlet public var facebookIcon: UIImageView?
	@IBOutlet public var shoppingCartIcon: UIImageView?
	@IBOutlet public var profileIcon: UIImageView?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		facebookIcon?.renderWithColor(color: .white)
		shoppingCartIcon?.renderWithColor(color: .white)
		profileIcon?.renderWithColor(color: .white)
    }
	
	// MARK: - Actions
	
	@IBAction func didPressLogoutButton(sender: UIButton) {
		PSUserManager.sharedInstance.logout()
	}
	
	@IBAction func didPressShoppingCartButton(sender: UIButton) {
		
	}
	
	@IBAction func didPressProfileButton(sender: UIButton) {
		let storyboard = UIStoryboard(name: kProfileStoryboard, bundle: nil)
		let vc = storyboard.instantiateInitialViewController()
		self.parent?.navigationController?.pushViewController(vc!, animated: true)
	}
}
