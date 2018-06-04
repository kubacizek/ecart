//
//  SummaryTableViewController.swift
//  eCart
//
//  Created by Jakub Cizek on 04/06/2018.
//  Copyright © 2018 Jakub Cizek. All rights reserved.
//

import UIKit

class SummaryTableViewController: UITableViewController {

	var itemsInCart: [CartModel] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()

		NotificationCenter.default.addObserver(forName: .currencyChanged, object: nil, queue: nil) { _ in
			self.navigationController?.popToRootViewController(animated: true)
		}
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0:
			return itemsInCart.count
		case 1:
			return 1
		case 2:
			return 1
		default:
			return 0
		}
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		switch indexPath.section {
		case 0:
			let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryItemCell", for: indexPath) as! SummaryItemCell
			let itemInCart = itemsInCart[indexPath.row]
			
			if let item = itemInCart.item {
				cell.itemImageView.image = UIImage(named: item.image)
				cell.descriptionLabel.text = item.localizedDescription
				if let rate = Utilities.rate, let currency = UserDefaults.standard.selectedCurrency {
					cell.priceLabel.text = String(format: "%.2f", item.price * rate * Double(itemInCart.quantity)) + " " + currency
				} else {
					cell.priceLabel.text = String(format: "%.2f", item.price * Double(itemInCart.quantity)) + " USD"
				}
				cell.countLabel.text = String(itemInCart.quantity) + "x"
			}
			
			return cell
		case 1:
			let cell = tableView.dequeueReusableCell(withIdentifier: "TotalCell", for: indexPath)
			let label = cell.viewWithTag(1) as? UILabel
			
			if let rate = Utilities.rate, let currency = UserDefaults.standard.selectedCurrency {
				let total = itemsInCart.map({ Double($0.quantity) * (($0.item?.price ?? 0) * rate) }).reduce(0, +)
				label?.text = ~"total" + String(format: "%.2f", total) + " " + currency
			} else {
				let total = itemsInCart.map({ Double($0.quantity) * ($0.item?.price ?? 0) }).reduce(0, +)
				label?.text = String(format: "%.2f", total) + " USD"
			}
			
			return cell
		case 2:
			let cell = tableView.dequeueReusableCell(withIdentifier: "ContinueCell", for: indexPath)
			let button = cell.viewWithTag(1) as? UIButton
			button?.setTitle(~"end", for: .normal)
			button?.backgroundColor = .clear
			button?.layer.cornerRadius = 5
			button?.layer.borderWidth = 1
			button?.layer.borderColor = button?.tintColor.cgColor
			button?.addTarget(self, action: #selector(endAction), for: .touchUpInside)
			return cell
		default:
			return UITableViewCell()
		}
    }
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch indexPath.section {
		case 0:
			return 101
		case 1:
			return 45
		case 2:
			return 51
		default:
			return 45
		}
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.section {
		case 2:
			endAction()
		default:()
		}
	}
	
	// MARK: Actions
	
	@objc func endAction(){
		navigationController?.popToRootViewController(animated: true)
	}

}
