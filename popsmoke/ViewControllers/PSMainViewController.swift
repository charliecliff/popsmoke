//
//  PSMainViewController.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/23/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

let NOTIFICATION_TOGGLE_NAV_DRAWER	= Notification.Name("NOTIFICATION_TOGGLE_NAV_DRAWER")
let NOTIFICATION_SHOW_NAV_DRAWER	= Notification.Name("NOTIFICATION_SHOW_NAV_DRAWER")
let NOTIFICATION_HIDE_NAV_DRAWER	= Notification.Name("NOTIFICATION_HIDE_NAV_DRAWER")

class PSMainViewController: UIViewController {

	private let navigation_container_segue = "navigation_container_segue"
	private var navDrawerIsHidden = true
	private var packetVC: PSPacketViewController?
	@IBOutlet weak var leadingConstraint: NSLayoutConstraint?
	@IBOutlet weak var trailingConstraint: NSLayoutConstraint?
	@IBOutlet weak var navBarWidthConstraint: NSLayoutConstraint?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		NotificationCenter.default.addObserver(self, selector: #selector(self.toggleNavDrawer), name: NOTIFICATION_TOGGLE_NAV_DRAWER, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(self.showNavDrawer), name: NOTIFICATION_SHOW_NAV_DRAWER, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(self.hideNavDrawer), name: NOTIFICATION_HIDE_NAV_DRAWER, object: nil)
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
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	
	// MARK: - Animations

	func toggleNavDrawer() {
		if navDrawerIsHidden {
			showNavDrawer()
		} else {
			hideNavDrawer()
		}
	}
	
	func showNavDrawer() {
		guard let delta = navBarWidthConstraint?.constant else {
			return
		}
		trailingConstraint?.constant = -delta
		leadingConstraint?.constant  = delta
		UIView.animate(withDuration: 0.5) {
			self.view.layoutIfNeeded()
			self.navDrawerIsHidden = false
		}
	}
	
	func hideNavDrawer() {
		trailingConstraint?.constant = 0
		leadingConstraint?.constant  = 0
		UIView.animate(withDuration: 0.5) {
			self.view.layoutIfNeeded()
			self.navDrawerIsHidden = true
		}
	}
}
