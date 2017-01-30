//
//  PSServerManager.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/30/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import Parse

class PSServerManager {

	init() {
		
		let clientConfig  = ParseClientConfiguration.init { (configuration) in
			configuration.server = "http://popsmokeapp.herokuapp.com/parse"
			configuration.applicationId = "popsmoke"
			configuration.clientKey = "popsmokemasterkey"
		}
		Parse.initialize(with: clientConfig)
		
		let player = PFObject(className: "TEST")
		player.setObject("John", forKey: "Name")
		player.setObject(1230, forKey: "Score")
		player.saveInBackground { (succeeded, error) -> Void in
			if succeeded {
				print("Object Uploaded")
			} else {
				print("Error: \(error)")
			}
		}
		
	}
}
