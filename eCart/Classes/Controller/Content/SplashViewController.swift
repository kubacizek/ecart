//
//  SplashViewController.swift
//  eCart
//
//  Created by Jakub Cizek on 04/06/2018.
//  Copyright © 2018 Jakub Cizek. All rights reserved.
//

import UIKit
import RealmSwift

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		getData()
    }
	
	func getData() {
		API.getCurrencies { currencies in
			if let currencies = currencies, currencies.count > 0 {
				API.getRates(completion: { rates in
					if let rates = rates, rates.count > 0 {
						self.performSegue(withIdentifier: "continue", sender: nil)
					}
				})
			} else {
				let currencies = Realm.shared.objects(Currency.self)
				let rates = Realm.shared.objects(Rate.self)
				
				let alert = UIAlertController(title: ~"notice", message: ~"serverError", preferredStyle: .alert)
				
				if currencies.count > 0 && rates.count > 0 {
					alert.addAction(UIAlertAction(title: ~"useOldData", style: .default, handler: { _ in
						self.performSegue(withIdentifier: "continue", sender: nil)
					}))
				}
				
				alert.addAction(UIAlertAction(title: ~"retry", style: .default, handler: { _ in
					self.getData()
				}))
				
				self.present(alert, animated: true, completion: nil)
			}
		}
	}
}
