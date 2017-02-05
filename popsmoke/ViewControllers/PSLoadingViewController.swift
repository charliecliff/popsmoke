//
//  PSLoadingViewController.swift
//  popsmoke
//
//  Created by Charles Cliff on 2/4/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PSLoadingViewController: UIViewController {
	
	private var subscription : Disposable?
	
	override func viewDidDisappear(_ animated: Bool) {
		subscription?.dispose()
		super.viewDidDisappear(true)
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)
		subscription = PSUserManager.sharedInstance.hasValidUser.asObservable().subscribe(onNext: {
			if $0 {
				self.launchMainApp()
			} else {
				self.launchSignIn()
			}
		})
	}
	
	// MARK: - Launching State
	
	private func launchOnboarding() {
		var storyboard = UIStoryboard()
		storyboard = UIStoryboard(name: kLoginStoryboard, bundle: nil)
		let vc = storyboard.instantiateInitialViewController()
		navigationController?.pushViewController(vc!, animated: true)
	}
	
	private func launchSignIn() {
		let storyboard = UIStoryboard(name: kLoginStoryboard, bundle: nil)
		let vc = storyboard.instantiateInitialViewController()
		navigationController?.pushViewController(vc!, animated: true)
	}
	
	private func launchMainApp() {
		let storyboard = UIStoryboard(name: kMainStoryboard, bundle: nil)
		let vc = storyboard.instantiateInitialViewController()
		navigationController?.pushViewController(vc!, animated: true)
	}

}
