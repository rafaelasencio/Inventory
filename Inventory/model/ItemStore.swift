//
//  ItemStore.swift
//  Inventory
//
//  Created by Rafa Asencio on 22/03/2020.
//  Copyright © 2020 Rafa Asencio. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    
    init() {
        if let data = try? Data(contentsOf: itemArchiveURL) {
            if let archivedData = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Item] {
                allItems = archivedData
            }
        }
    }
    /*
    init() {
        for _ in 0..<5{
            createItem()
        }
    }
    */
    
    func saveChanges() -> Bool {
        print("Saving items to: \(itemArchiveURL.path)")
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: allItems, requiringSecureCoding: false)
            try data.write(to: itemArchiveURL)
            return true
        } catch {
            return false
        }
    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.firstIndex(of: item) {
        allItems.remove(at: index)
        }
    }
    //a caller of this function is free to ignore the result of calling this function
    @discardableResult func createItem() -> Item {
        let newItem = Item(name: "New Item", serialNumber: nil, valueInDollars: 0)
        allItems.append(newItem)
        return newItem
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        // Get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]
        // Remove item from array
        allItems.remove(at: fromIndex)
        // Insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
    }
}
