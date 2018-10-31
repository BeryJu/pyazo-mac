//
//  PyazoAPI.swift
//  pyazo
//
//  Created by Jens Langhammer on 31/10/2018.
//  Copyright © 2018 Jens Langhammer. All rights reserved.
//

import Foundation
import Alamofire

class PyazoAPI {
    
    static let DEFAULT_SERVER = "i.beryju.org"
    static let KEY_DO_NOTIFY = "DO_NOTIFY"
    static let KEY_DO_CLIP = "DO_CLIP"
    static let KEY_DO_OPEN = "DO_OPEN"
    static let KEY_SERVER = "SERVER"
   
    var doNotify = true
    var doClip = true
    var doOpen = true
    var server = ""
    
    init() {
        let defaults = UserDefaults.standard
        self.doNotify = defaults.bool(forKey: PyazoAPI.KEY_DO_NOTIFY)
        self.doClip = defaults.bool(forKey: PyazoAPI.KEY_DO_CLIP)
        self.doOpen = defaults.bool(forKey: PyazoAPI.KEY_DO_OPEN)
        self.server = defaults.string(forKey: PyazoAPI.KEY_SERVER) ?? PyazoAPI.DEFAULT_SERVER
    }
    
    func showNotification(body: String) -> Void {
        if (self.doNotify) {
            let notification = NSUserNotification()
            notification.title = "Pyazo"
            notification.informativeText = body
            notification.soundName = NSUserNotificationDefaultSoundName
            NSUserNotificationCenter.default.deliver(notification)
        } else {
            print("Not showing notification since it's disabled")
        }
    }
    
    func setClipboard(value: String) -> Void {
        if (self.doClip) {
            let pasteboard = NSPasteboard.general
            pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
            pasteboard.setString(value, forType: NSPasteboard.PasteboardType.string)
        } else {
            print("Not setting clipboard since it's disabled")
        }
    }
    
    func openURL(url: String) -> Void {
        if (self.doOpen) {
            NSWorkspace.shared.open(URL(string: url)!)
        } else {
            print("Not opening since it's disabled")
        }
    }
    
    func upload(url: URL) -> Void {
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(url as URL , withName: "imagedata")
                multipartFormData.append("id".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName :"id")
            },
            to: "https://\(server)/upload/",
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseString(completionHandler: { response in
                        print(response.result.value as Any)
                        self.showNotification(body: response.result.value!)
                        self.setClipboard(value: response.result.value!)
                        self.openURL(url: response.result.value!)
                    })
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        )
    }
    
}
