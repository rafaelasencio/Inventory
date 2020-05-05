//
//  DetailViewController.swift
//  Inventory
//
//  Created by Rafa Asencio on 25/03/2020.
//  Copyright © 2020 Rafa Asencio. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK: - IBOulets
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var serialNumberField: UITextField!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var removePictureBarButton: UIBarButtonItem!
    
    // MARK: - Variables
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    var imageStore: ImageStore!
        
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    // MARK: - View life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        let imageToDisplay = imageStore.image(forKey: item.itemKey)
        imageView.image = imageToDisplay
        removePictureBarButton.isEnabled = imageView.image != nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(changeDate))
        dateLabel.isUserInteractionEnabled = true
        gesture.numberOfTapsRequired = 1
        dateLabel.addGestureRecognizer(gesture)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.endEditing(true)
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text ?? ""
        if let valueText = valueField.text, let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }
    // MARK: - Actions
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func removePicture(_ sender: UIBarButtonItem) {
      imageStore.deleteImage(forKey: item.itemKey)
      imageView.image = nil
      removePictureBarButton.isEnabled = false
    }
    
    @objc func changeDate(){
        performSegue(withIdentifier: "changeDate", sender: nil)
    }
    
    // MARK: - Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      switch segue.identifier {
      case "changeDate"?:
        let dateCreatedViewController = segue.destination as! DateCreatedViewController
        dateCreatedViewController.item = item
      default:
        preconditionFailure("Unexpected segue identifier.")
      }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        imageView.image = image
        imageStore.setImage(image, forKey: item.itemKey)
        removePictureBarButton.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
}


