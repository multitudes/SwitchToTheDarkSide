//
//  ContentView.swift
//  SwitchToTheDarkSide
//
//  Created by Laurent B on 11/11/2021.
//

import Introspect
import SwiftUI

struct ContentView: View {
	var body: some View {
		VStack {
			Text("Appearance")
				.font(.title)
			AppearanceSelectionPicker()
				.padding()
		}
	}
}


// check LocalizedStringKey instead of string for localisation!
enum Appearance: LocalizedStringKey, CaseIterable, Identifiable {
	case light
	case dark
	case automatic

	var id: String { UUID().uuidString }
}


struct AppearanceSelectionPicker: View {
	@Environment(\.colorScheme) var colorScheme
	@State private var selectedAppearance = Appearance.automatic

	var body: some View {
		HStack {
			Text("Appearance")
				.padding()
				.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
			Picker(selection: $selectedAppearance, label: Text("Appearance"))  {
				ForEach(Appearance.allCases) { appearance in
					Text(appearance.rawValue)
						.tag(appearance)
				}
			}
			.pickerStyle(WheelPickerStyle())
			.frame(width: 150, height: 50, alignment: .center)
			.padding()
			.clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
			.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
			.introspectUIPickerView { picker in
				picker.subviews[1].backgroundColor = UIColor.clear
			}
		}
		.padding()

		.onChange(of: selectedAppearance, perform: { value in
			print("changed to ", value)
			switch value {
				case .automatic:
					UserDefaults.userInterfaceStyle = 0
				case .light:
					UserDefaults.userInterfaceStyle = 1
				case .dark:
					UserDefaults.userInterfaceStyle = 2
			}
		})
		.onAppear {
			print(colorScheme)
			print("UserDefaults.userInterfaceStyle",UserDefaults.userInterfaceStyle)
			switch UserDefaults.userInterfaceStyle {
				case 0:
					selectedAppearance = .automatic
				case 1:
					selectedAppearance = .light
				case 2:
					selectedAppearance = .dark
				default:
					selectedAppearance = .automatic
			}
		}
	}
}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

// using introspect!
extension View {
	public func introspectUIPickerView(customize: @escaping (UIPickerView) -> ()) -> some View {
		return inject(UIKitIntrospectionView(
			selector: { introspectionView in
				guard let viewHost = Introspect.findViewHost(from: introspectionView) else {
					return nil
				}
				return Introspect.previousSibling(containing: UIPickerView.self, from: viewHost)
			},
			customize: customize
		))
	}
}
