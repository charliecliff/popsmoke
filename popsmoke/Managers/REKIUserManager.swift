//
//  REKIUserManager.swift
//  Reki
//
//  Created by Charles Cliff on 9/18/16.
//  Copyright © 2016 Reki. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

let instagram_token_key     = "instaToken"
let user_id_key             = "user_id"
let aws_cognito_fake_token  = "not_a_real_token"

let userErrorCode = 800

protocol PSLoginStateMachine: class {
	func didCompleteOnboarding()
	func didCompleteSignInWithToken(token: String?)
}

class REKIUserManager {
    
	static let sharedInstance = REKIUserManager()
	
	private var userProvider : PSUserProvider?

	private var _socialMediaToken: String?

	var hasCompletedOnboarding  = false
	
	private(set) var user = PSUser()
	var hasValidUser = Variable( false )
	
	init() {
		userProvider = PSParseClient()
	}
	
	private func set(user: PSUser) {
		self.user = user
		hasValidUser.value = false
		hasValidUser.value = true
	}
	
	func validateUserForSocialMediaToken(token: String?, completion: ((_ error: NSError?) -> Void)?) {
		
		REKIFacebookClient.getUserDataForToken(token: (token)!, completion: { (userData, error) in
			
			guard userData != nil else {
				if completion != nil {
					// TODO: Define Social Media Error Codes
					completion!(NSError.init(domain: "REKI", code: userErrorCode, userInfo: nil))
				}
				return
			}
			let userID = PSUserFactory.userIDFromDictionary(userDictionary: userData!)
						self.userProvider?.getUserForUserID(userID: userID, completion: { (user, error) in
				guard error == nil else {
					self.createUserForSocialMediaToken(token: token, completion: completion)
					return
				}
				guard (user != nil) else {
					return
				}
				self.set(user: user!)
				completion?(nil)
			})
			
		})
	}
	
	func createUserForSocialMediaToken(token: String?, completion: ((_ error: NSError?) -> Void)?) {
		
		hasValidUser.value = false
		REKIFacebookClient.getUserDataForToken(token: (token)!, completion: { (userData, error) in
			guard userData != nil else {
				return
			}
			guard let newUser = PSUserFactory.userForDictionary(userDictionary: userData!) else {
				return
			}
			self.set(user: newUser)
			self.userProvider?.postUser(user: self.user, completion: completion)
		})
	}
	
	// MARK: - PSLoginStateMachine
	
	func didCompleteOnboarding() {
		hasCompletedOnboarding = true
		// TODO: Save User to Disk
	}
	
	func didCompleteSignInWithToken(token: String?) {
		_socialMediaToken = token
		self.validateUserForSocialMediaToken(token: token) { (error) in
			// TODO: Save User to Disk
		}
	}
}
