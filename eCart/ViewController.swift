//
//  ViewController.swift
//  eCart
//
//  Created by Jakub Cizek on 03/06/2018.
//  Copyright © 2018 Jakub Cizek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		API.getItems { items in
			
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

