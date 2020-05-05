//
//  CustomTextField.swift
//  Inventory
//
//  Created by Rafa Asencio on 25/03/2020.
//  Copyright © 2020 Rafa Asencio. All rights reserved.
//

import UIKit

import UIKit

class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
     func setup() {
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    override func becomeFirstResponder() -> Bool {
      return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        
      return super.resignFirstResponder()
    }
}
