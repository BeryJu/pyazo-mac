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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dragView.delegate = self
        progress.isHidden = true
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

extension HomeController {

    static func freshController() -> HomeController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier("HomeController")
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? HomeController else {
            fatalError("Why cant i find HomeController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}

