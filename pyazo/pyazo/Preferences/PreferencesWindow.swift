//
//  PreferencesWindow.swift
//  pyazo
//
//  Created by Jens Langhammer on 31/10/2018.
//  Copyright © 2018 Jens Langhammer. All rights reserved.
//

import Cocoa

protocol PreferencesWindowDelegate {
    func preferencesDidUpdate()
}

class PreferencesWindow: NSWindowController, NSWindowDelegate {

    @IBOutlet var server: NSTextField!
    @IBOutlet var doClip: NSButton!
    @IBOutlet var doNotify: NSButton!
    @IBOutlet var doOpen: NSButton!
    
    var delegate: PreferencesWindowDelegate?
    
    override var windowNibName : String! {
        return "PreferencesWindow"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        // Init PyazoAPI to get current settings
        let api = PyazoAPI()
        server.stringValue = api.server
        doClip.state = api.doClip ? NSControl.StateValue.on : NSControl.StateValue.off
        doNotify.state = api.doNotify ? NSControl.StateValue.on : NSControl.StateValue.off
        doOpen.state = api.doOpen ? NSControl.StateValue.on : NSControl.StateValue.off
    }
    
    func windowWillClose(_ notification: Notification) {
        let defaults = UserDefaults.standard
        defaults.set(server.stringValue, forKey: PyazoAPI.KEY_SERVER)
        defaults.set(doClip.state.rawValue, forKey: PyazoAPI.KEY_DO_CLIP)
        defaults.set(doNotify.state.rawValue, forKey: PyazoAPI.KEY_DO_NOTIFY)
        defaults.set(doOpen.state.rawValue, forKey: PyazoAPI.KEY_DO_OPEN)
        delegate?.preferencesDidUpdate()
    }
    
}
