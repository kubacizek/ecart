//
//  Localization.swift
//
//
//  Created by Jakub Cizek on 11/11/2017.
//  Copyright © 2017 Jakub Cizek. All rights reserved.
//

import Foundation

public extension NSNotification.Name {
	public static let localizationDidChange = NSNotification.Name(rawValue: "LocalizationDidChange")
}

public struct Localization {
	
	public private(set) static var url: URL!
	public private(set) static var languages: [String] = []
	public private(set) static var dictionary: [String: String] = [:]
	public static var currentLanguage: String = "" {
		didSet {
			if let jsonData = try? Data(contentsOf: url.appendingPathComponent(currentLanguage + ".json")) {
				dictionary = (try? JSONSerialization.jsonObject(with: jsonData, options: [])) as? [String: String] ?? [:]
			} else {
				dictionary = [:]
			}
			
			NotificationCenter.default.post(name: .localizationDidChange, object: nil)
		}
	}
	
	public static func load(url: URL) throws {
		self.url = url
		let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
		
		languages.removeAll()
		
		for url in contents {
			guard url.pathExtension == "json" else { continue }
			languages.append(url.deletingPathExtension().lastPathComponent)
		}
		
		currentLanguage = languages[0]
	}
	
	public static func languageName(identifier: String, uppercased: Bool = false) -> String {
		let locale = Locale(identifier: identifier)
		let langName = locale.localizedString(forIdentifier: identifier) ?? identifier
		if uppercased {
			return langName.uppercased(with: locale)
		} else {
			return langName
		}
	}
	
}

prefix operator ~
public prefix func ~ (a: String) -> String {
	return Localization.dictionary[a] ?? a
}

public prefix func ~ (a: Any?) -> String? {
	guard let dict = a as? [String: Any] else { return nil }
	return (dict[Localization.currentLanguage] as? String) ?? (dict["default"] as? String)
}

prefix operator ~~
public prefix func ~~ (a: String) -> String {
	return a + "@" + Localization.currentLanguage
}
