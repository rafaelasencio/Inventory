//
//  DateCreatedViewController.swift
//  Inventory
//
//  Created by Rafa Asencio on 26/03/2020.
//  Copyright © 2020 Rafa Asencio. All rights reserved.
//

import UIKit

class DateCreatedViewController: UIViewController {

    var datePicker: UIDatePicker!
    var item: Item!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Date Created"
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.date = item.dateCreated
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(datePicker)
        datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        item.dateCreated = datePicker.date
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
