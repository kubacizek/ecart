//
//  CartItem.swift
//  eCart
//
//  Created by Jakub Cizek on 04/06/2018.
//  Copyright © 2018 Jakub Cizek. All rights reserved.
//

import Foundation

struct CartItem: Codable {
	var id: Int
	var description: DescriptionItem
	var price: Double
}

struct DescriptionItem: Codable {
	var en: String
	var cs: String
}

