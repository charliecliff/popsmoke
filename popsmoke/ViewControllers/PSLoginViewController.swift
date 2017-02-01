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
import SVProgressHUD

class PSLoginViewController: UIViewController {

	var progressHUD: SVProgressHUD?
	@IBOutlet weak var facebookLoginButton: FBSDKLoginButton?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		bindToObservables()
		facebookLoginButton?.readPermissions = ["public_profile", "email", "user_friends"]
		facebookLoginButton?.delegate = self
    }
	
	private func segueToMainViewController() {
		SVProgressHUD.dismiss()
		let storyboard = UIStoryboard(name: kMainStoryboard, bundle: nil)
		let vc = storyboard.instantiateInitialViewController()
		present(vc!, animated: true, completion:nil)
	}
	
	private func bindToObservables(){ // TODO: Pull this into a PopSmoke View Controller Super Class
		bindToUserManager()
	}
	
	private func bindToUserManager() {
		_ = PSUserManager.sharedInstance.hasValidUser.asObservable().subscribe(onNext: {
			if $0 {
				self.segueToMainViewController()
			}
		})
	}
}

extension PSLoginViewController: FBSDKLoginButtonDelegate {
	
	func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
		if ((error) != nil) || result.isCancelled {
			return
		}
		SVProgressHUD.show()
		let token = FBSDKAccessToken.current().tokenString
		PSUserManager.sharedInstance.didCompleteSignInWithToken(token: token)
	}
	
	func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
		print("User Logged Out")
	}
}
