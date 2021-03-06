//
//  PSParseClient.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/31/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import Parse

fileprivate let server				= "http://popsmokeapp.herokuapp.com/parse"
fileprivate let applicationId		= "popsmoke"
fileprivate let clientKey			= "popsmokemasterkey"
fileprivate let parseUserKey		= "USER"
fileprivate let parsePacketKey		= "PACKET"
fileprivate let parseFirstNameKey	= "first_name"
fileprivate let parseLastNameKey	= "last_name"
fileprivate let parseUserIDKey		= "user_id"

class PSParseClient: PSUserProvider {

	init() {
		let clientConfig  = ParseClientConfiguration.init { (configuration) in
			configuration.server = server
			configuration.applicationId = applicationId
			configuration.clientKey = clientKey
		}
		Parse.initialize(with: clientConfig)
	}
	
	func getUserForUserID(userID: String, completion: UserClosure?) {
		let query = PFQuery.init(className: parseUserKey)
		query.getObjectInBackground(withId: userID) { (result, error) in
			print("completed")
			completion?(nil, error as NSError?)
		}
	}
	
	func postUser(user: PSUser, completion: ((_ error: NSError?) -> Void)?) {
		let player = PFObject(className: parseUserKey)
		if let tmp = user.firstName as Any? {
			player.setObject(tmp, forKey: parseFirstNameKey)

		}
		if let tmp = user.lastName as Any? {
			player.setObject(tmp, forKey: parseLastNameKey)
		}
		if let tmp = user.userID as Any? {
			player.setObject(tmp, forKey: parseUserIDKey)
		}
		player.saveInBackground { (succeeded, error) -> Void in
			if completion != nil {
				completion!(error as NSError?)
			}
		}
	}
	
	func putUser(user: PSUser, completion: ((_ error: NSError?) -> Void)?) {
		self.postUser(user: user, completion: completion)
	}
}
