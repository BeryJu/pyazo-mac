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
    
    let popover = NSPopover()
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    
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
        // Menubar
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("MenubarIcon"))
            button.action = #selector(togglePopover(_:))
        }
        popover.contentViewController = HomeController.freshController()
        // Hotkey
        if let keyCombo = KeyCombo(keyCode: kVK_ANSI_R, cocoaModifiers: [.shift, .command]) {
            let hotKey = HotKey(identifier: "ShiftCommandR", keyCombo: keyCombo) { hotKey in
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
        // Touchbar
        if #available(OSX 10.12.1, *) {
            NSApplication.shared.isAutomaticCustomizeTouchBarMenuItemEnabled = true
        }
        print("We started")
    }

    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            popover.performClose(sender)
        } else {
            if let button = statusItem.button {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
    }

}

