//
//  API.swift
//  eCart
//
//  Created by Jakub Cizek on 04/06/2018.
//  Copyright © 2018 Jakub Cizek. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

struct API {
	static func getItems(completion: (([CartItem]?) -> Void)? = nil) {
		let filePath = Bundle.main.bundleURL.appendingPathComponent("example-items.json")
		
		let request = Alamofire.request(filePath)
		request.responseJSON { response in
			if let result = response.result.value as? [[String: Any]] {
				
				let jsonDecoder = JSONDecoder()
				var items: [CartItem] = []
				
				for item in result {
					if let jsonData = try? JSONSerialization.data(withJSONObject: item),
						let json = String(data: jsonData, encoding: .utf8),
						let data = json.data(using: .utf8),
						let cartItem = try? jsonDecoder.decode(CartItem.self, from: data) {
						
						items.append(cartItem)
					}
				}
				
				completion?(items)
				
			} else {
				print("getItems ERROR:", response.result.value as Any)
				completion?(nil)
			}
		}
	}
	
	static func getCurrencies(completion: (([Currency]?) -> Void)? = nil) {
		let request = Alamofire.request(baseUrl + "list?access_key=" + accessKey)
		request.responseJSON { response in
			if let result = response.result.value as? [String: Any],
				let currenciesResult = result["currencies"] as? [String: String] {
				
				var currencies: [Currency] = []
				
				try! Realm.shared.write {
					for item in currenciesResult {
						let currency = Currency()
						currency.code = item.key
						currency.currencyName = item.value
						currencies.append(currency)
						Realm.shared.add(currency, update: true)
					}
				}
				completion?(currencies)
			} else {
				print("getCurrencies ERROR:", response.result.value as Any)
				completion?(nil)
			}
		}
	}
	
	static func getRates(completion: (([Rate]?) -> Void)? = nil) {
		let request = Alamofire.request(baseUrl + "live?access_key=" + accessKey)
		request.responseJSON { response in
			if let result = response.result.value as? [String: Any],
				let ratesResult = result["quotes"] as? [String: Double] {
				
				var rates: [Rate] = []
				
				try! Realm.shared.write {
					for item in ratesResult {
						let rate = Rate()
						rate.code = item.key
						rate.rate = item.value
						rates.append(rate)
						Realm.shared.add(rate, update: true)
					}
				}
				completion?(rates)
			} else {
				print("getRates ERROR:", response.result.value as Any)
				completion?(nil)
			}
		}
	}
	
}
