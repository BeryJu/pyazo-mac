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
    @IBOutlet var progress: NSProgressIndicator!
    
    var preferencesWindow: PreferencesWindow!
    var popover: NSPopover!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dragView.delegate = self
        progress.isHidden = true
    }
    
    @IBAction func touchbarButton(_ sender: Any) {
        let screenshot = Screenshot()
        screenshot.capture()
        PyazoAPI().upload(url: URL(fileURLWithPath: screenshot.file)) {
            screenshot.cleanup()
        }
    }
    
    @IBAction func quitButton(_ sender: Any) {
        exit(0)
    }
    
    override func awakeFromNib() {
        self.preferencesWindow = PreferencesWindow()
    }
    
    @IBAction func preferencesClick(_ sender: Any) {
        self.popover.performClose(self)
        self.preferencesWindow.showWindow(self)
    }
    
    static func freshController(container: NSPopover) -> HomeController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier("HomeController")
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? HomeController else {
            fatalError("Why cant i find HomeController? - Check Main.storyboard")
        }
        viewcontroller.popover = container
        return viewcontroller
    }

}

extension HomeController: DragViewDelegate {
    
    func dragView(didDragFileWith path: String) {
        self.progress.isHidden = false
        self.progress.startAnimation(self.view)
        self.textField.isHidden = true
        
        let url = NSURL(fileURLWithPath: path)
        PyazoAPI().upload(url: url as URL) {
            self.progress.isHidden = true
            self.progress.stopAnimation(self.view)
            self.textField.isHidden = false
            print("Uploaded")
        }
    }

}
