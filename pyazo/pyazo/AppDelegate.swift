//
//  AppDelegate.swift
//  pyazo
//
//  Created by Jens Langhammer on 31/10/2018.
//  Copyright © 2018 Jens Langhammer. All rights reserved.
//

import Cocoa
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
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

