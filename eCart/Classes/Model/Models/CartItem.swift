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
	var image: String
	var price: Double
	var localizedDescription: String {
		if Localization.currentLanguage == "cs" {
			return description.cs
		} else {
			return description.en
		}
	}
}

struct DescriptionItem: Codable {
	var en: String
	var cs: String
}

class CartModel {
	var quantity = 0
	var item: CartItem?
	
	init(quantity: Int, item: CartItem) {
		self.quantity = quantity
		self.item = item
	}
}
