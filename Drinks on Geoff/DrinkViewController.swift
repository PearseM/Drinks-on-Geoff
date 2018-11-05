//
//  DrinkViewController.swift
//  Drinks on Geoff
//
//  Created by Pearse Moloney on 02/11/2018.
//  Copyright © 2018 Pearse Moloney. All rights reserved.
//

import UIKit
import os.log

class DrinkViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var volumeTextField: UITextField!
    @IBOutlet weak var percentageTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var imagePreview: UIImageView!

    @IBOutlet weak var saveDrink: UIBarButtonItem!
    var drink: Drink?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add new drink" //Sets title
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveDrink else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let name = nameTextField.text ?? ""
        let photo = imagePreview.image
        if let volume = Float(volumeTextField.text!), let percentage = Float(percentageTextField.text!), let price = Float(priceTextField.text!){
            let volume = volume
            let percentage = percentage
            let price = price
            
            drink = Drink(name: name, volume: volume, percentage: percentage, price: price, image: photo)
        }
        
        
    }
    
    @IBAction func tapImage(_ sender: UITapGestureRecognizer) {
        //Hides keyboard by deactivating text fields
        nameTextField.resignFirstResponder()
        volumeTextField.resignFirstResponder()
        percentageTextField.resignFirstResponder()
        priceTextField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        imagePreview.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}

