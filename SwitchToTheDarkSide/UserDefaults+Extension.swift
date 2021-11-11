//
//  UserDefaults+Extension.swift
//  SwitchToTheDarkSide
//
//  Created by Laurent B on 11/11/2021.
//

import SwiftUI

/// We need this for ios13 because @AppStorage only avalaible in ios14? it works the same as @AppStorage
/// https://www.avanderlee.com/swift/property-wrappers/
@propertyWrapper
struct UserDefault<Value> {
	let key: String
	let defaultValue: Value
	var container: UserDefaults = .standard

	var wrappedValue: Value {
		get {
			return container.object(forKey: key) as? Value ?? defaultValue
		}
		set {
			container.set(newValue, forKey: key)
		}
	}
}

// all the static vars are being used as a some point in the app to store color themes, or onboarding status etc
extension UserDefaults {
	@UserDefault(key: "userInterfaceStyle", defaultValue: 2)
	static var userInterfaceStyle: Int
}
