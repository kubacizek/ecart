//
//  CartTableViewController.swift
//  eCart
//
//  Created by Jakub Cizek on 04/06/2018.
//  Copyright © 2018 Jakub Cizek. All rights reserved.
//

import UIKit

class CartTableViewController: UITableViewController, ItemCellDelegate {

	var items: [CartItem] = []
	var itemsInCart: [CartModel] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		API.getItems { responseItems in
			if let responseItems = responseItems {
				self.items = responseItems
				self.tableView.reloadData()
			} else {
				// show error
			}
		}
		
		API.getCurrencies()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
	
	// MARK: ItemCellDelegate
	
	func addToCart(item: CartItem) {
		if let inCart = itemsInCart.first(where: { $0.item?.id == item.id }) {
			inCart.quantity += 1
		} else {
			itemsInCart.append(CartModel(quantity: 1, item: item))
		}
		tableView.reloadData()
	}
	
	func stepperChangedValue(item: CartItem, value: Int) {
		print(item, value)
		if let inCart = itemsInCart.first(where: { $0.item?.id == item.id }) {
			inCart.quantity = value
		}
		tableView.reloadData()
	}

    // MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0:
			return items.count
		case 1:
			return 1
		default:
			return 0
		}
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch indexPath.section {
		case 0:
			let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
			let item = items[indexPath.row]
			if let inCart = itemsInCart.first(where: { $0.item?.id == item.id }) {
				cell.countLabel.text = String(inCart.quantity)
				if inCart.quantity > 0 {
					UIView.animate(withDuration: 0.3) {
						cell.stepperView.alpha = 1
						cell.addToCartButton.alpha = 0
					}
				} else {
					UIView.animate(withDuration: 0.3) {
						cell.stepperView.alpha = 0
						cell.addToCartButton.alpha = 1
					}
				}
			}
			
			cell.item = item
			cell.delegate = self
			cell.itemImageView.image = UIImage(named: item.image)
			cell.descriptionLabel.text = item.localizedDescription
			cell.priceLabel.text = String(item.price)
			
			return cell
		case 1:
			let cell = tableView.dequeueReusableCell(withIdentifier: "ContinueCell", for: indexPath)
			let button = cell.viewWithTag(1) as? UIButton
			button?.setTitle(~"continue", for: .normal)
			button?.backgroundColor = .clear
			button?.layer.cornerRadius = 5
			button?.layer.borderWidth = 1
			button?.layer.borderColor = button?.tintColor.cgColor
			return cell
		default:
			return UITableViewCell()
		}
    }
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch indexPath.section {
		case 0:
			return 101
		default:
			return 51
		}
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.section {
		case 1:()
		default:()
		}
		tableView.deselectRow(at: indexPath, animated: true)
	}

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
