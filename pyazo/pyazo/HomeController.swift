//
//  ViewController.swift
//  pyazo
//
//  Created by Jens Langhammer on 31/10/2018.
//  Copyright © 2018 Jens Langhammer. All rights reserved.
//

import Cocoa
import Alamofire

class HomeController: NSViewController {

    @IBOutlet var dragView: DragView!
    @IBOutlet var imageView: NSImageView!
    @IBOutlet var textField: NSTextField!
    @IBOutlet var progress: NSProgressIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dragView.delegate = self
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}

extension HomeController: DragViewDelegate {
    func dragView(didDragFileWith path: String) {
        let url = NSURL(fileURLWithPath: path)
        PyazoAPI().upload(url: url as URL)
    }
}
