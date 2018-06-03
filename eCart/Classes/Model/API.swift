//
//  API.swift
//  eCart
//
//  Created by Jakub Cizek on 04/06/2018.
//  Copyright © 2018 Jakub Cizek. All rights reserved.
//

import Foundation
import Alamofire

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
}
