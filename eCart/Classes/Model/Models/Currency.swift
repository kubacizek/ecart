//
//  Currency.swift
//  eCart
//
//  Created by Jakub Cizek on 04/06/2018.
//  Copyright © 2018 Jakub Cizek. All rights reserved.
//

import Foundation
import RealmSwift

class Currency: Object {
	@objc dynamic var code: String = ""
	@objc dynamic var currencyName: String = ""
	
	override static func primaryKey() -> String? {
		return "code"
	}
}
