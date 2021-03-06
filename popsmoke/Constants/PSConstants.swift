//
//  PSConstants.swift
//  popsmoke
//
//  Created by Charles Cliff on 1/26/17.
//  Copyright © 2017 Charles Cliff. All rights reserved.
//

import UIKit

// MARK: - Storyboard IDs
let kMainStoryboard		= "PSMainStoryboard"
let kLoginStoryboard	= "PSLogin"
let kLoadingStoryboard	= "PSLoading"
let kProfileStoryboard	= "PSProfile"

// MARK: - User Factory
let kKeyUserID      = "id"
let kKeyFirstName   = "first_name"
let kKeyLastName    = "last_name"

// MARK: - Colors
let dark_grey	= UIColor.init(colorLiteralRed: 65.0/255, green: 65.0/255, blue: 65.0/255, alpha: 1.0)
let light_grey	= UIColor.init(colorLiteralRed: 224.0/255, green: 224.0/255, blue: 224.0/255, alpha: 1.0)
let form_row_background = UIColor.init(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.5)

// MARK: - Errors

// MARK: - FileNames
let kUserFileName		= "/current_user.txt"
let kLicenseFileName	= "/current_license.txt"

// MARK: - Allowed Military URLS

// MARK: - Time Constants
let free_trial_expiration = 121000000.0 // Two Weeks in Seconds
