//
//  SettingsTableViewController.swift
//  eCart
//
//  Created by Jakub Cizek on 04/06/2018.
//  Copyright © 2018 Jakub Cizek. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

	@IBOutlet weak var languageTitleLabel: UILabel! {
		didSet {
			languageTitleLabel.text = ~"settings.language"
		}
	}
	@IBOutlet weak var languageLabel: UILabel! {
		didSet {
			if Localization.currentLanguage == "cs" {
				languageLabel.text = ~"settings.czech"
			} else {
				languageLabel.text = ~"settings.english"
			}
		}
	}
	@IBOutlet weak var currencyTitleLabel: UILabel! {
		didSet {
			currencyTitleLabel.text = ~"settings.currency"
		}
	}
	@IBOutlet weak var currencyLabel: UILabel! {
		didSet {
			if let currency = UserDefaults.standard.selectedCurrency {
				currencyLabel.text = currency
			} else {
				currencyLabel.text = ~"settings.notSet"
			}
		}
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

        title = ~"tab.settings"
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		if let currency = UserDefaults.standard.selectedCurrency {
			currencyLabel.text = currency
		} else {
			currencyLabel.text = ~"settings.notSet"
		}
	}

    // MARK: - Table view data source

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.row {
		case 0:
			let optionMenu = UIAlertController(title: nil, message: ~"settings.chooseLanguage", preferredStyle: .actionSheet)
			
			if let popoverController = optionMenu.popoverPresentationController {
				popoverController.sourceView = tableView.cellForRow(at: indexPath)
				popoverController.sourceRect = tableView.cellForRow(at: indexPath)?.bounds ?? CGRect.zero
			}
			
			let initialViewController = UIStoryboard.main.instantiateInitialViewController()
			
			optionMenu.addAction(UIAlertAction(title: ~"settings.czech", style: .default) { _ in
				Localization.currentLanguage = "cs"
				UserDefaults.standard.selectedLanguage = "cs"
				UIApplication.shared.keyWindow?.rootViewController = initialViewController
				UIApplication.shared.keyWindow?.makeKeyAndVisible()
			})
			optionMenu.addAction(UIAlertAction(title: ~"settings.english", style: .default) { _ in
				Localization.currentLanguage = "en"
				UserDefaults.standard.selectedLanguage = "en"
				UIApplication.shared.keyWindow?.rootViewController = initialViewController
				UIApplication.shared.keyWindow?.makeKeyAndVisible()
			})
			
			optionMenu.addAction(UIAlertAction(title: ~"close", style: .cancel) { _ in })
			
			present(optionMenu, animated: true, completion: nil)
		case 1:
			performSegue(withIdentifier: "showCurrencies", sender: nil)
		default:()
		}
		tableView.deselectRow(at: indexPath, animated: true)
	}

}
