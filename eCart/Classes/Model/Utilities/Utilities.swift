//
//  Utilities.swift
//  eCart
//
//  Created by Jakub Cizek on 04/06/2018.
//  Copyright © 2018 Jakub Cizek. All rights reserved.
//

import Foundation
import RealmSwift

class Utilities {
	static var rate: Double? {
		if let currentCurrency = UserDefaults.standard.selectedCurrency,
			let rate = Array(Realm.shared.objects(Rate.self).filter("code == %@", ("USD" + currentCurrency))).first {
			return rate.rate
		} else {
			return nil
		}
	}
}
