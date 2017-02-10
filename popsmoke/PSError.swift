//
//  PSError.swift
//  popsmoke
//
//  Created by Charles Cliff on 2/8/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

class PSErrorHandler: NSObject {

	class func presentErrorWith(title: String?, message: String?) {
		
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let OKAction = UIAlertAction(title: "OK", style: .default) { action in
			// ...
		}
		alertController.addAction(OKAction)
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		appDelegate.window!.rootViewController?.present(alertController, animated: true, completion:nil)
	}
	
	class func presentError(error: NSError?) {
		
		guard error != nil else{
			return
		}
		
		let alertController = UIAlertController(title: "Error" , message: error!.localizedDescription, preferredStyle: .alert)
		let OKAction = UIAlertAction(title: "OK", style: .default) { action in
			// ...
		}
		alertController.addAction(OKAction)
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		appDelegate.window!.rootViewController?.present(alertController, animated: true, completion:nil)
	}
}

