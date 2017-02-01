//
//  AppDelegate.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/13/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		if PSUserManager.sharedInstance.hasValidUser.value {
			launchMainApp()
		} else {
			launchSignIn()
		}
		
		return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
	}
	
	func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool{
		let sourceApplication: String? = options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String
		return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: sourceApplication, annotation: nil)
	}
	
	// MARK: - Launching State
	
	private func launchOnboarding() {
		var storyboard = UIStoryboard()
		storyboard = UIStoryboard(name: kLoginStoryboard, bundle: nil)
		self.window?.rootViewController = storyboard.instantiateInitialViewController()
		self.window?.makeKeyAndVisible()
	}
	
	private func launchSignIn() {
		let storyboard = UIStoryboard(name: kLoginStoryboard, bundle: nil)
		self.window?.rootViewController = storyboard.instantiateInitialViewController()
		self.window?.makeKeyAndVisible()
	}
	
	private func launchMainApp() {
		let storyboard = UIStoryboard(name: kMainStoryboard, bundle: nil)
		self.window?.rootViewController = storyboard.instantiateInitialViewController()
		self.window?.makeKeyAndVisible()
	}
}
