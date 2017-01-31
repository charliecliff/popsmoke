//
//  PSLoginViewController.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/31/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class PSLoginViewController: UIViewController {

	@IBOutlet weak var facebookLoginButton: FBSDKLoginButton?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.facebookLoginButton?.readPermissions = ["public_profile", "email", "user_friends"]
		self.facebookLoginButton?.delegate = self
    }
	
	private func segueToMainViewController() {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateInitialViewController()
		self.present(vc!, animated: true, completion:nil)
	}
}

extension PSLoginViewController: FBSDKLoginButtonDelegate {
	
	func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
		if ((error) != nil) {
			return
		}
		if result.isCancelled {
			return
		}
		else {
			let token = FBSDKAccessToken.current().tokenString
			REKIUserManager.sharedInstance.didCompleteSignInWithToken(token: token)
		}
	}
	
	func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
		print("User Logged Out")
	}
}
