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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}