//
//  Screenshot.swift
//  pyazo
//
//  Created by Jens Langhammer on 31/10/2018.
//  Copyright © 2018 Jens Langhammer. All rights reserved.
//

import Foundation

class Screenshot {
    
    var file = ""
    
    init() {
        let tempDir = NSTemporaryDirectory()
        self.file = URL(fileURLWithPath: tempDir).appendingPathComponent("pyazo_screenshot.png").path
    }

    func cleanup() {
        do {
            try FileManager().removeItem(atPath: self.file)
        } catch let error {
            print(error)
        }
    }
    
    func capture() {
        let task = Process()
        task.launchPath = "/usr/sbin/screencapture"
        task.arguments = ["-i", self.file]
        task.launch()
        task.waitUntilExit()
    }
    
}
