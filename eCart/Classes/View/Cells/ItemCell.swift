//
//  ItemCell.swift
//  eCart
//
//  Created by Jakub Cizek on 04/06/2018.
//  Copyright © 2018 Jakub Cizek. All rights reserved.
//

import UIKit

protocol ItemCellDelegate {
	func addToCart(item: CartItem)
	func stepperChangedValue(item: CartItem, value: Int)
}

class ItemCell: UITableViewCell {

	var item: CartItem!
	var delegate: ItemCellDelegate?
	@IBOutlet weak var itemImageView: UIImageView!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!
	@IBOutlet weak var addToCartButton: UIButton! {
		didSet {
			addToCartButton.setTitle(~"addToCart", for: .normal)
		}
	}
	
	@IBOutlet weak var stepperView: UIView!
	@IBOutlet weak var countLabel: UILabel!
	@IBAction func addToCart(_ sender: Any) {
		delegate?.addToCart(item: item)
	}
	
	@IBAction func stepperAction(_ sender: UIStepper) {
		delegate?.stepperChangedValue(item: item, value: Int(sender.value))
	}
}
