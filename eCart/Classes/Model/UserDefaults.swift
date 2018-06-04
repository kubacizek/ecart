//
//  UserDefaults.swift
//  eCart
//
//  Created by Jakub Cizek on 04/06/2018.
//  Copyright © 2018 Jakub Cizek. All rights reserved.
//

import Foundation

extension UserDefaults {
	var selectedLanguage: String? {
		get {
			return string(forKey: "language")
		}
		set {
			set(newValue, forKey: "language")
			synchronize()
		}
	}
}
