//
//  CurrenciesTableViewController.swift
//  eCart
//
//  Created by Jakub Cizek on 04/06/2018.
//  Copyright © 2018 Jakub Cizek. All rights reserved.
//

import UIKit
import RealmSwift

class CurrenciesTableViewController: UITableViewController {

	var currencies: [Currency] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()

        currencies = Array(Realm.shared.objects(Currency.self).sorted(byKeyPath: "code", ascending: true))
		tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath)

        let label = cell.viewWithTag(1) as? UILabel
		label?.text = currencies[indexPath.row].code + " - " + currencies[indexPath.row].currencyName

        return cell
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let currency = currencies[indexPath.row]
		UserDefaults.standard.selectedCurrency = currency.code
		NotificationCenter.default.post(name: .currencyChanged, object: nil)
		navigationController?.popViewController(animated: true)
	}
	
}
