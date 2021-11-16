//
//  SceneDelegate.swift
//  SwitchToTheDarkSide
//
//  Created by Laurent B on 11/11/2021.
//

import Combine
import SwiftUI
import UIKit


// this is again a new way to achieve the ligt/ dark mode switch
extension UserDefaults {
	@objc dynamic var userInterfaceStyle: Int {
		return integer(forKey: "userInterfaceStyle")
	}
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	// for changing the appearance light and dark mode useing combine
	var cancellable: AnyCancellable?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

		// for the light and dark mode toggle. observing the changes on userdefaults with a publisher
		cancellable = UserDefaults.standard.publisher(for: \.userInterfaceStyle)
			.sink { _ in
				self.updateUserInterfaceStyle()
			}
		
		// Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
		// If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
		// This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

		// Create the SwiftUI view that provides the window contents.
		let contentView = ContentView()

		// Use a UIHostingController as window root view controller.
		if let windowScene = scene as? UIWindowScene {
		    let window = UIWindow(windowScene: windowScene)
		    window.rootViewController = UIHostingController(rootView: contentView)
		    self.window = window
		    window.makeKeyAndVisible()
		}
	}

	func sceneDidDisconnect(_ scene: UIScene) {
		// Called as the scene is being released by the system.
		// This occurs shortly after the scene enters the background, or when its session is discarded.
		// Release any resources associated with this scene that can be re-created the next time the scene connects.
		// The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
	}

	func sceneDidBecomeActive(_ scene: UIScene) {
		// Called when the scene has moved from an inactive state to an active state.
		// Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
	}

	func sceneWillResignActive(_ scene: UIScene) {
		// Called when the scene will move from an active state to an inactive state.
		// This may occur due to temporary interruptions (ex. an incoming phone call).
	}

	func sceneWillEnterForeground(_ scene: UIScene) {
		// Called as the scene transitions from the background to the foreground.
		// Use this method to undo the changes made on entering the background.
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
		// Called as the scene transitions from the foreground to the background.
		// Use this method to save data, release shared resources, and store enough scene-specific state information
		// to restore the scene back to its current state.
	}

	func updateUserInterfaceStyle() {
		DispatchQueue.main.async {
			switch UserDefaults.userInterfaceStyle {
			case 0:
				self.window?.overrideUserInterfaceStyle = .unspecified
			case 1:
				self.window?.overrideUserInterfaceStyle = .light
			case 2:
				self.window?.overrideUserInterfaceStyle = .dark
			default:
				self.window?.overrideUserInterfaceStyle = .unspecified
			}
		}
	}
}

