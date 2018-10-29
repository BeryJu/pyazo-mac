//
//  AppDelegate.swift
//  pyazo
//
//  Created by Jens Langhammer on 08/10/2018.
//  Copyright © 2018 Jens Langhammer. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    let popover = NSPopover()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named: "MenubarIcon")
            button.image?.isTemplate = true
            button.action = #selector(togglePopover(_:))
        }
        popover.contentViewController = PyazoMenubarController.freshController()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }

    func showPopover(sender: Any?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }

    func closePopover(sender: Any?) {
        popover.performClose(sender)
    }

}
