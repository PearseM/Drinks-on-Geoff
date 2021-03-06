//
//  DrinkViewController.swift
//  Drinks on Geoff
//
//  Created by Pearse Moloney on 02/11/2018.
//  Copyright © 2018 Pearse Moloney. All rights reserved.
//

import UIKit
import os.log

class DrinkViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var volumeTextField: UITextField!
    @IBOutlet weak var percentageTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet var unitPicker: UIPickerView!
    
    var pickerData: [String] = ["ml","CL","L"]
    var selectedUnit = "ml"
    var returnVolume: Float = 0
    var unitMultiplier: Float = 1

    @IBOutlet weak var saveDrink: UIBarButtonItem!
    var drink: Drink?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add new drink" //Sets title
        updateSaveButton()

        self.unitPicker.delegate = self
        self.unitPicker.dataSource = self
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
        
        //Sets the multiplier to the correct value
        if (selectedUnit == "CL") {
            unitMultiplier *= 10
        } else if (selectedUnit == "L") {
            unitMultiplier *= 1000
        }
        
        
        if let volume = Float(volumeTextField.text!){
            returnVolume = volume*unitMultiplier
        }
        
        let name = nameTextField.text ?? ""
        let photo = imagePreview.image
        if  let percentage = Float(percentageTextField.text!), let price = Float(priceTextField.text!){
            drink = Drink(name: name, volume: returnVolume, percentage: percentage, price: price, image: photo, numberOfDrinks: 1)
        }
    }
    
    //Adding an image - Need to change to use camera
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
    
    //Really clever
    @IBAction func nameEditingChanged(_ sender: Any) {
        updateSaveButton()
    }
    
    @IBAction func volumeEditingChanged(_ sender: Any) {
        updateSaveButton()
    }
    
    @IBAction func percentageEditingChanged(_ sender: Any) {
        updateSaveButton()
    }
    
    @IBAction func priceEditingChanged(_ sender: Any) {
        updateSaveButton()
    }
    
    private func updateSaveButton(){
        if nameTextField.text?.isEmpty ?? true || volumeTextField.text?.isEmpty ?? true || percentageTextField.text?.isEmpty ?? true || priceTextField.text?.isEmpty ?? true{
            saveDrink.isEnabled = false
        }
        else {
            saveDrink.isEnabled = true
        }
    }
    
    //Add drink is cancelled
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        //dismiss(animated: true, completion: nil)
        _ = navigationController?.popViewController(animated: true)
    }
    
    /*
     Code Below is for the unit picker
     */
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedUnit = pickerData[row]
    }
    
}

