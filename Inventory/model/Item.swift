//
//  Item.swift
//  Inventory
//
//  Created by Rafa Asencio on 22/03/2020.
//  Copyright © 2020 Rafa Asencio. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {

    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    var dateCreated: Date
    let itemKey: String
    
    init(name: String, serialNumber: String?, valueInDollars: Int) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = Date()
        self.itemKey = UUID().uuidString
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(valueInDollars, forKey: "valueInDollars")
        aCoder.encode(serialNumber, forKey: "serialNumber")
        aCoder.encode(dateCreated, forKey: "dateCreated")
        aCoder.encode(itemKey, forKey: "itemKey")
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as! String
        valueInDollars = coder.decodeInteger(forKey: "valueInDollars")
        serialNumber = coder.decodeObject(forKey: "serialNumber") as! String?
        dateCreated = coder.decodeObject(forKey: "dateCreated") as! Date
        itemKey = coder.decodeObject(forKey: "itemKey") as! String
        super.init()
    }
}
