//
//  AppDelegate.swift
//  FramezillaExample
//
//  Created by Nikita Ermolenko on 13/05/2017.
//  Copyright © 2017 Nikita Ermolenko. All rights reserved.
//

import UIKit
import Framezilla

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    @IBOutlet var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Calling `initializeKeyboardTracking` is not strictly required, but it helps avoid inconsistent keyboard state
        // if the first `nui_keyboard` usage happens after keyboard was presented
        // Maker.initializeKeyboardTracking(with: window)
        return true
    }
}

