//
//  Rates.swift
//  eCart
//
//  Created by Jakub Cizek on 04/06/2018.
//  Copyright © 2018 Jakub Cizek. All rights reserved.
//

import Foundation
import RealmSwift

class Rate: Object {
	@objc dynamic var code: String = ""
	@objc dynamic var rate: Double = 0.0
	
	override static func primaryKey() -> String? {
		return "code"
	}
}
