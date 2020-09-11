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
    var draggingIndexPaths: Set<IndexPath> = []
    
    // Tell the collectionView how many items it should hold.
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count // Simply the number of items in our array.
    }
    
    // Produce the collection view item for a given position in the collection view.
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        // Construct an 'item' --- an instance of the NSView defined in our xib.
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier("CollectionViewItem"), for: indexPath) as! CollectionViewItem
        item.delegate = self
        // Changing the label in the item view, based on the corresponding item in our data source.
        item.numberLabel.stringValue = items[indexPath[1]]
        return item
    }
    
    // Tell the collectionview that an item will be displayed
    func collectionView(_ collectionView: NSCollectionView, willDisplay item: NSCollectionViewItem, forRepresentedObjectAt indexPath: IndexPath) {
        
    }

    func collectionView(_ collectionView: NSCollectionView, pasteboardWriterForItemAt indexPath: IndexPath) -> NSPasteboardWriting? {
        let pasteboardItem = NSPasteboardItem()
        pasteboardItem.setString(items[indexPath.item], forType: NSPasteboard.PasteboardType.string)
        return pasteboardItem
    }
    
    func collectionView(_ collectionView: NSCollectionView, validateDrop draggingInfo: NSDraggingInfo, proposedIndexPath proposedDropIndexPath: AutoreleasingUnsafeMutablePointer<NSIndexPath>, dropOperation proposedDropOperation: UnsafeMutablePointer<NSCollectionView.DropOperation>) -> NSDragOperation {
        return .move
    }
    
    // About to drag
    func collectionView(_ collectionView: NSCollectionView, draggingSession session: NSDraggingSession, willBeginAt screenPoint: NSPoint, forItemsAt indexPaths: Set<IndexPath>) {
        draggingIndexPaths = indexPaths
    }
    
    // End of drag
    func collectionView(_ collectionView: NSCollectionView, draggingSession session: NSDraggingSession, endedAt screenPoint: NSPoint, dragOperation operation: NSDragOperation) {
        draggingIndexPaths = []
    }
    
    func collectionView(_ collectionView: NSCollectionView, acceptDrop draggingInfo: NSDraggingInfo, indexPath: IndexPath, dropOperation: NSCollectionView.DropOperation) -> Bool {
        for fromIndexPath in draggingIndexPaths {
            let draggedItem = items.remove(at: fromIndexPath.item)
            print(fromIndexPath.item, indexPath.item)
            NSAnimationContext.current.duration = 0.5;
            collectionView.animator().deleteItems(at: [fromIndexPath]);
            items.insert(draggedItem, at: (indexPath.item<=fromIndexPath.item) ? indexPath.item : (indexPath.item-1))
            collectionView.animator().insertItems(at: [IndexPath(item: (indexPath.item<=fromIndexPath.item) ? indexPath.item : (indexPath.item-1), section: 0)])
            //collectionView.animator().moveItem(at: fromIndexPath, to: IndexPath(item: (indexPath.item<=fromIndexPath.item) ? indexPath.item : (indexPath.item-1), section: 0))
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.registerForDraggedTypes([NSPasteboard.PasteboardType.string])
        
    }
}

extension ViewController: ItemDelegate {
    func buttonPressed(val : String) {
        print("Hello!" + val)
    }
    
    
}
