//
//  ViewController.swift
//  pyazo
//
//  Created by Jens Langhammer on 31/10/2018.
//  Copyright © 2018 Jens Langhammer. All rights reserved.
//

import Cocoa

class HomeController: NSViewController {

    @IBOutlet var dragView: DragView!
    @IBOutlet var imageView: NSImageView!
    @IBOutlet var textField: NSTextField!
    
    var preferencesWindow: PreferencesWindow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dragView.delegate = self
    }
    
    override func awakeFromNib() {
        self.preferencesWindow = PreferencesWindow()
    }
    
    @IBAction func preferencesClick(_ sender: Any) {
        self.preferencesWindow.showWindow(self)
    }

}

extension HomeController: DragViewDelegate {
    func dragView(didDragFileWith path: String) {
        let url = NSURL(fileURLWithPath: path)
        PyazoAPI().upload(url: url as URL)
    }
}
