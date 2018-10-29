//
//  PyazoAPI.swift
//  pyazo
//
//  Created by Jens Langhammer on 08/10/2018.
//  Copyright © 2018 Jens Langhammer. All rights reserved.
//

import Foundation

class PyazoAPI {
    
    static let SETTING_KEY_SERVER = "api_server"
    static let BASE_API_FORMAT = "http://%s/upload/"
    
    let BASE_API: String
    
    init () {
        let server = UserDefaults().string(forKey: PyazoAPI.SETTING_KEY_SERVER)
        self.BASE_API = String(format: PyazoAPI.BASE_API_FORMAT, arguments: [server!])
    }
    
    func upload(_ query: String) {
        let session = URLSession.shared
        _ = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let url = URL(string: BASE_API)
        let task = session.dataTask(with: url!) { data, response, err in
            // first check for a hard error
            if let error = err {
                NSLog("weather api error: \(error)")
            }
            
            // then check the response code
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200: // all good!
                    if let dataString = String(data: data!, encoding: .utf8) {
                        NSLog(dataString)
                    }
                case 401: // unauthorized
                    NSLog("weather api returned an 'unauthorized' response. Did you set your API key?")
                default:
                    NSLog("weather api returned response: %d %@", httpResponse.statusCode, HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))
                }
            }
        }
        task.resume()
    }
    
}
