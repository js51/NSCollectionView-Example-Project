//
//  CollectionViewItem.swift
//  NSCollectionViewExample
//
//  Created by Joshua Stevenson on Thursday23/1/20.
//  Copyright © 2020 Joshua Stevenson. All rights reserved.
//

import Cocoa

class CollectionViewItem: NSCollectionViewItem {
    
    @IBOutlet weak var numberLabel: NSTextField! // The label which will change depending on our data.
    @IBOutlet weak var box: NSBox!
    var delegate: ItemDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let area = NSTrackingArea.init(rect: self.view.bounds, options: [NSTrackingArea.Options.mouseEnteredAndExited, NSTrackingArea.Options.activeAlways], owner: self, userInfo: nil)
        self.view.addTrackingArea(area)
        // Do view setup here.
    }
    
    @IBAction func doSomething(_ sender: Any) {
        self.delegate?.buttonPressed(val: "I am " + numberLabel.stringValue)
    }
    
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        
        let frame = self.view.layer?.frame;
        self.view.layer?.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        self.view.layer?.frame = frame!; // Fix the location shift caused from anchor change
        
        let scaleAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 0.2
        scaleAnimation.fromValue = 1;
        scaleAnimation.toValue = 1.04;
        scaleAnimation.isRemovedOnCompletion = false;
        scaleAnimation.fillMode = CAMediaTimingFillMode.forwards
        self.view.layer?.add(scaleAnimation, forKey: "scale")
    }
    
    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        
        let frame = self.view.layer?.frame;
        self.view.layer?.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        self.view.layer?.frame = frame!; // Fix the location shift caused from anchor change
        
        let scaleAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = 0.2
        scaleAnimation.fromValue = 1.04;
        scaleAnimation.toValue = 1;
        scaleAnimation.isRemovedOnCompletion = false;
        self.view.layer?.add(scaleAnimation, forKey: "scale")
    }
    
}

protocol ItemDelegate {
    func buttonPressed(val : String)
}
