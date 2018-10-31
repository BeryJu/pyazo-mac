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
    
    func showNotification(body: String) -> Void {
        let notification = NSUserNotification()
        notification.title = "Pyazo"
        notification.informativeText = body
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.default.deliver(notification)
    }
    
    func setClipboard(value: String) -> Void {
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
        pasteboard.setString(value, forType: NSPasteboard.PasteboardType.string)
    }
    
    func upload(url: URL) -> Void {
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(url as URL , withName: "imagedata")
                multipartFormData.append("id".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName :"id")
            },
            to: "http://localhost:8000/upload/",
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseString(completionHandler: { response in
                        print(response.result.value as Any)
                        self.showNotification(body: response.result.value!)
                        self.setClipboard(value: response.result.value!)
                    })
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        )
    }
    
}
