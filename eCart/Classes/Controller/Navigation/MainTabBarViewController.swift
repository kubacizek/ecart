//
//  MainTabBarViewController.swift
//  eCart
//
//  Created by Jakub Cizek on 04/06/2018.
//  Copyright © 2018 Jakub Cizek. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		tabBar.items?[0].title = ~"tab.items"
		tabBar.items?[1].title = ~"tab.settings"
	}
}
