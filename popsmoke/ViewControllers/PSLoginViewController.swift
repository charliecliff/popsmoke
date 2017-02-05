//
//  PSLoginViewController.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/31/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import FBSDKCoreKit
import FBSDKLoginKit
import SVProgressHUD

class PSLoginViewController: UIViewController {

	private var centerX: NSLayoutConstraint?
	private var centerY: NSLayoutConstraint?
	private var subscription : Disposable?
	var progressHUD: SVProgressHUD?
	var facebookLoginButton: FBSDKLoginButton?
	@IBOutlet weak var bottomView: UIView?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		facebookLoginButton = FBSDKLoginButton.init()
		facebookLoginButton?.readPermissions = ["public_profile", "email", "user_friends"]
		facebookLoginButton?.delegate = self
		facebookLoginButton?.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(facebookLoginButton!)
		
		centerX = NSLayoutConstraint.init(item: facebookLoginButton as Any, attribute: .centerX, relatedBy: .equal, toItem: bottomView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
		centerY = NSLayoutConstraint.init(item: facebookLoginButton as Any, attribute: .centerY, relatedBy: .equal, toItem: bottomView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
		view?.addConstraint(centerX!)
		view?.addConstraint(centerY!)
	}
	
	
	override func viewDidDisappear(_ animated: Bool) {
		subscription?.dispose()
		super.viewDidDisappear(true)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)
		bindToUserManager()
	}
	
	private func segueToMainViewController() {
		SVProgressHUD.dismiss()
		let storyboard = UIStoryboard(name: kMainStoryboard, bundle: nil)
		let vc = storyboard.instantiateInitialViewController()
		present(vc!, animated: true, completion:nil)
	}
	
	private func bindToUserManager() {
		subscription = PSUserManager.sharedInstance.hasValidUser.asObservable().subscribe(onNext: {
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
