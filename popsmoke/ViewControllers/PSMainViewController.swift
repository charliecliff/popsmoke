//
//  PSMainViewController.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/23/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PSMainViewController: UIViewController {

	private let navigation_container_segue = "navigation_container_segue"
	private var subscription : Disposable?
	private var settingVCIsHidden = true
	private var packetVC: PSPacketViewController?

	@IBOutlet weak var overlay: UIImageView?
	@IBOutlet weak var settingView: UIView?
	@IBOutlet weak var settingTopConstraint: NSLayoutConstraint?
	@IBOutlet weak var menuView: SkullAndBonesMenuView?
	
	override func viewDidDisappear(_ animated: Bool) {
		subscription?.dispose()
		super.viewDidDisappear(true)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)
		subscription = PSUserManager.sharedInstance.hasValidUser.asObservable().subscribe(onNext: {
			if !($0) {
				self.navigationController?.popToRootViewController(animated: true)
			}
		})
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == navigation_container_segue {
			guard let navVC = segue.destination as? UINavigationController else {
				//TODO: Handle the errors in a global error alert
				return
			}
			guard let vc = navVC.viewControllers.first as? PSPacketViewController else {
				//TODO: Handle the errors in a global error alert
				return
			}
			packetVC = vc
		}
	}
	
	// MARK: - Actions
	
	@IBAction func didPressSettingButton(sender: UIButton) {
		toggleSettings()
	}
	
	// MARK: - Animations
	
	func toggleSettings() {
		if settingVCIsHidden {
			menuView?.addSkullAppearAnimation()
			showSettings()
		} else {
			menuView?.removeSkullAppearAnimation()
			hideSetting()
		}
	}
	
	func showSettings() {
		guard let delta = settingView?.frame.size.height else {
			return
		}
		settingTopConstraint?.constant = -delta
		UIView.animate(withDuration: 0.3) {
			self.view.layoutIfNeeded()
			self.settingVCIsHidden = false
			self.overlay?.alpha = 0.8
		}
	}
	
	func hideSetting() {
		settingTopConstraint?.constant = -0
		UIView.animate(withDuration: 0.3) {
			self.view.layoutIfNeeded()
			self.settingVCIsHidden = true
			self.overlay?.alpha = 0.0
		}
	}
}
