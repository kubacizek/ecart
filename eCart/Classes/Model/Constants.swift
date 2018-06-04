//
//  Constants.swift
//  eCart
//
//  Created by Jakub Cizek on 04/06/2018.
//  Copyright © 2018 Jakub Cizek. All rights reserved.
//

import Foundation
import RealmSwift

extension API {
	static let baseUrl = "http://apilayer.net/api/"
	static let accessKey = "1841fd8cd68ae7dae7f44c150fb4a6ca"
}

extension Realm {
	@nonobjc static let shared = try! Realm()
}
