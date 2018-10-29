//
//  PyazoMenubarController.swift
//  pyazo
//
//  Created by Jens Langhammer on 08/10/2018.
//  Copyright © 2018 Jens Langhammer. All rights reserved.
//

import Cocoa

class PyazoMenubarController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    static func freshController() -> PyazoMenubarController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier("PyazoMenubarController")
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? PyazoMenubarController else {
            fatalError("Why cant i find QuotesViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
    
}
