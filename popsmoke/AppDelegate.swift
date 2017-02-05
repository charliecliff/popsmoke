//
//  AppDelegate.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/13/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		let storyboard = UIStoryboard(name: kLoadingStoryboard, bundle: nil)
		self.window?.rootViewController = storyboard.instantiateInitialViewController()
		self.window?.makeKeyAndVisible()
		
		return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
	}
	
	func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool{
		let sourceApplication: String? = options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String
		return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: sourceApplication, annotation: nil)
	}
}
