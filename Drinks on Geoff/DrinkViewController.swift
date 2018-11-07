//
//  DrinkViewController.swift
//  Drinks on Geoff
//
//  Created by Pearse Moloney on 02/11/2018.
//  Copyright © 2018 Pearse Moloney. All rights reserved.
//

import UIKit
import os.log
import MapKit

class DrinkViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate{
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var volumeTextField: UITextField!
    @IBOutlet weak var percentageTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var unitTextField: UITextField!
    @IBOutlet var unitPicker: UIPickerView!
    @IBOutlet var numberOfDrinksDisplay: UILabel!
    
    @IBOutlet weak var popupView: UIView!

    var pickerData: [String] = ["ml","CL","L"]
    var selectedUnit = "ml"
    var returnVolume: Float = 0
    var unitMultiplier: Float = 1
    var numberOfDrinks: Float = 1
    var sendLocation: Bool = false

    @IBOutlet weak var saveDrink: UIBarButtonItem!
    
    var drinkTypes: [Drink] = [] //The struct which defines the type of drink
    var CurrentInstanceOfDrink: instanceOfDrink? //
    var isNewDrink = true
    var instanceDrinkType: Drink?
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        unitTextField.inputView = popupView //Sets the keyboard of the unit field to be the popup view
        title = "Add new drink" //Sets title
        updateSaveButton()

        self.unitPicker.delegate = self
        self.unitPicker.dataSource = self
        
        //location usage authorisation needs finising
        self.locationManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
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
        
        
        let photo = imagePreview.image
        if let volume = Float(volumeTextField.text!), let price = Float(priceTextField.text!), let name = nameTextField.text, let percentage = Float(percentageTextField.text!){
            
            returnVolume = volume*unitMultiplier
            
            
            instanceDrinkType = Drink(name: name, percentage: percentage)
            
            var index = 0
            while (index < drinkTypes.count){
                if (name == drinkTypes[index].name && percentage == drinkTypes[index].percentage) {
                    instanceDrinkType = drinkTypes[index]
                    isNewDrink = false
                    break
                }
                
                index = index + 1
                
            }
            
            CurrentInstanceOfDrink = instanceOfDrink(drink: instanceDrinkType!, volume: returnVolume, price: price, numberOfDrinks: Int(numberOfDrinks), image: photo)
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
        if nameTextField.text?.isEmpty ?? true || volumeTextField.text?.isEmpty ?? true || percentageTextField.text?.isEmpty ?? true || priceTextField.text?.isEmpty ?? true || unitTextField.text?.isEmpty ?? true {
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
    //The "done" button function for the popup picker view
    @IBAction func closePickerView(_ sender: Any) {
        unitTextField.text = selectedUnit
        unitTextField.endEditing(true) //Closes the popup
        updateSaveButton()
    }
    //Stepper value changes the number of drinks
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        numberOfDrinks = Float(sender.value)
        numberOfDrinksDisplay.text = String(Int(numberOfDrinks))
    }
    //
    @IBAction func shareLocationSwitched(_ sender: UISwitch) {
        if (CLLocationManager.locationServicesEnabled() == false){
            sender.isOn = false
        }
        sendLocation.toggle()
        
    }
    ///
    
}

