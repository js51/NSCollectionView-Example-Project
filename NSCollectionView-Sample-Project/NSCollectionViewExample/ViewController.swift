//
//  ViewController.swift
//  NSCollectionViewExample
//
//  Created by Joshua Stevenson on Thursday23/1/20.
//  Copyright © 2020 Joshua Stevenson. All rights reserved.
//

import Cocoa

// The ViewController for the entire view (not just the view controller).
// We implement the collection view data source, and delegate protocols.
class ViewController: NSViewController,
NSCollectionViewDelegate, NSCollectionViewDataSource {
    
    var items = [ "One", "Two", "Three" ] // This is our (very simple) data source, usually controlled by some other class.
    @IBOutlet weak var myCollectionView: NSCollectionView! // The collection view itself.
    
    // Tell the collectionView how many items it should hold.
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count // Simply the number of items in our array.
    }
    
    // Produce the collection view item for a given position in the collection view.
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        // Construct an 'item' --- an instance of the NSView defined in our xib.
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier("CollectionViewItem"), for: indexPath) as! CollectionViewItem
        // Changing the label in the item view, based on the corresponding item in our data source.
        item.numberLabel.stringValue = items[indexPath[1]]
        return item
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

