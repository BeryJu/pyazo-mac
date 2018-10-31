//
//  AppDelegate.swift
//  pyazo
//
//  Created by Jens Langhammer on 31/10/2018.
//  Copyright © 2018 Jens Langhammer. All rights reserved.
//

import Cocoa
import Magnet
import Carbon.HIToolbox
import Sentry

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    func application(application: NSApplication,
                     didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        do {
            Client.shared = try Client(dsn: "https://dfcc6acbd9c543ea8d4c9dbf4ac9a8c0@sentry.services.beryju.org/4")
            try Client.shared?.startCrashHandler()
        } catch let error {
            print("\(error)")
        }
        return true
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let keyCombo = KeyCombo(keyCode: kVK_ANSI_R, cocoaModifiers: [.shift, .command]) {
            let hotKey = HotKey(identifier: "CommandControlB", keyCombo: keyCombo) { hotKey in
                // CMD+SHIFT+R Pressed
                print("Global hotkey triggered")
                let screenshot = Screenshot()
                screenshot.capture()
                PyazoAPI().upload(url: URL(fileURLWithPath: screenshot.file)) {
                    screenshot.cleanup()
                }
            }
            hotKey.register()
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

}

