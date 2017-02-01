//
//  PSParseClient.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/31/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import Parse

fileprivate let server			= "http://popsmokeapp.herokuapp.com/parse"
fileprivate let applicationId	= "popsmoke"
fileprivate let clientKey		= "popsmokemasterkey"

fileprivate let parseUserKey	= "USER"
fileprivate let parsePacketKey	= "PACKET"

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
		player.setObject("John", forKey: "Name")
		player.setObject(1230, forKey: "Score")
		player.saveInBackground { (succeeded, error) -> Void in
			if completion != nil {
				completion!(error as NSError?) // TODO: Fix these type casting calls
			}
		}
	}
	
	func putUser(user: PSUser, completion: ((_ error: NSError?) -> Void)?) {
		
		self.postUser(user: user, completion: completion)
	}
}
