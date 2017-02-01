//
//  REKIUserClient.swift
//  Reki
//
//  Created by Charles Cliff on 9/20/16.
//  Copyright © 2016 Reki. All rights reserved.
//

import Foundation

typealias UserClosure = ((_ user: PSUser?, _ error: NSError?) -> Void)

protocol PSUserProvider: class {

  func getUserForUserID(userID: String, completion: UserClosure?)
  func postUser(user: PSUser, completion: ((_ error: NSError?) -> Void)?)
  func putUser(user: PSUser, completion: ((_ error: NSError?) -> Void)?)
}
