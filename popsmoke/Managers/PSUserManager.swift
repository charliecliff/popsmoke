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

class PSUserManager {
    
	static let sharedInstance = PSUserManager()
	private var _userProvider : PSUserProvider?
	private var _socialMediaToken: String?
	private(set) var user = PSUser()
	private(set) var hasValidUser = Variable( false )
	
	init() {
		_userProvider = PSParseClient()
		loadUser()
	}
	
	private func set(user: PSUser) {
		self.user = user
	}

	// MARK: - Persistence
	
	private func saveUser() {
		PSPersistenceManager.save(user: user)
	}
	
	private func loadUser() {
		do {
			let user = try PSPersistenceManager.loadUser()
			set(user: user!)
		} catch PersistenceError.userPersistence {
			//TODO: Handle the errors in a global error alert
		} catch {
			//TODO: Handle the errors in a global error alert
		}
	}
	
	// MARK: - Facebook Interactions

	func logout() {
		do {
			try PSPersistenceManager.clearUser()
			REKIFacebookClient.logout()
			hasValidUser.value = false
		}
		catch {
			//TODO: Handle the errors in a global error alert
		}
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
						self._userProvider?.getUserForUserID(userID: userID, completion: { (user, error) in
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
		REKIFacebookClient.getUserDataForToken(token: (token)!, completion: { (userData, error) in
			guard userData != nil else {
				return
			}
			guard let newUser = PSUserFactory.userForDictionary(userDictionary: userData!) else {
				return
			}
			self.set(user: newUser)
			self.hasValidUser.value = true
			self._userProvider?.postUser(user: self.user, completion: completion)
		})
	}
	
	// MARK: - PSLoginStateMachine
	
	func didCompleteOnboarding() {
		saveUser()
	}
	
	func didCompleteSignInWithToken(token: String?) {
		_socialMediaToken = token
		validateUserForSocialMediaToken(token: token) { (error) in
			self.saveUser()
		}
	}
}
