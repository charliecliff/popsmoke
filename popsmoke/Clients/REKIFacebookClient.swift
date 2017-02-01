//
//  REKIFacebookClient.swift
//  Reki
//
//  Created by Charles Cliff on 11/18/16.
//  Copyright © 2016 Reki. All rights reserved.
//

import UIKit
import FBSDKCoreKit

/**
{
  id = 10206780794468941;
  name = "Charlie Cliff";
}
*/
/**
{
  data =     (
    {
      id = 588518608194;
      name = "Jim Rabuck";
    },
    {
      id = 10156711129445051;
      name = "John Houser";
    }
  );
  paging =     {
    cursors =         {
      after = QVFIUklQaG1YeFlRNmFsV0VEZAEh5OC11LVdEZA1pmTlNvRmVkZA1FJTHhQVUlyX3Nxd19DSkZAnUUdMRndPOTZAYUFUteXkZD;
      before = QVFIUjV4elRfYkRWeDZAfLVZABc2tYVUdoTkNVYVJNZAU1KTHR2Tk1Nbk0wVGlkdEhZAZAW1kVVBIZA2dXVjlkQ2d4M3U0NGsZD;
    };
  };
  summary =     {
    "total_count" = 587;
  };
}
*/

fileprivate let kFBKeyID      = "id"
fileprivate let kFBKeyName    = "name"
fileprivate let kFBKeyData    = "data"
fileprivate let kFBKeyPaging  = "paging"
fileprivate let kFBKeyCursors = "cursors"
fileprivate let kFBKeyAfter   = "after"
fileprivate let kFBKeyBefore  = "before"

class REKIFacebookClient: NSObject {
	
	class func parseFacebookData(dictionary: [String: String]?) -> [String: String]? {
		guard dictionary != nil else {
		return nil
		}
		let fullName = dictionary![kFBKeyName]
		let fullNameArr = fullName!.components(separatedBy: " ")
		let firstName = fullNameArr[0]
		let lastName = fullNameArr[1]
		let id = dictionary![kFBKeyID]
		let outputDictionary: [String: String] = [kKeyUserID: id!, kKeyFirstName: firstName, kKeyLastName: lastName]
		return outputDictionary
	}
	
	class func getUserDataForToken(token: String, completion: ((_ userData: [String: String]?, _ error: NSError?) -> Void)?) {
  
		let facebookRequest = "/me"
		
		let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: facebookRequest, parameters: nil)
		graphRequest.start(completionHandler: { (connection, result, error) -> Void in
			guard (error == nil) else {
				if completion != nil {
					completion!(nil, error as NSError?)
				}
				return
			}
			guard let facebookDictionary = result as? [String: String] else {
				return
			}
			guard let userData = self.parseFacebookData(dictionary: facebookDictionary) else {
				return
			}
			if completion != nil {
				completion!(userData, nil)
			}
		})
	}
}
