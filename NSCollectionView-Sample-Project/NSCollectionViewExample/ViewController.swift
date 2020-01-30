//
//  ViewController.swift
//  NSCollectionViewExample
//
//  Created by Joshua Stevenson on Thursday23/1/20.
//  Copyright © 2020 Joshua Stevenson. All rights reserved.
//

import Cocoa

// We implement the collection view data source, and delegate protocols.
class ViewController: NSViewController,
NSCollectionViewDelegate, NSCollectionViewDataSource {
    
    var items = [ "One", "Two", "Three" ]
    @IBOutlet weak var myCollectionView: NSCollectionView!
    
    // Tell the collectionView how many items it should hold.
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // Produce the collection view item for a given position in the collection view.
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier("CollectionViewItem"), for: indexPath) as! CollectionViewItem
        item.numberLabel.stringValue = items[indexPath[1]]
        return item
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

