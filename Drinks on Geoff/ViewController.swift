//
//  ViewController.swift
//  Drinks on Geoff
//
//  Created by Pearse Moloney on 02/11/2018.
//  Copyright © 2018 Pearse Moloney. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var volumeInput: UITextField!
    
    
    var pickerData: [String] = [String]()
    var unitChosen: String = ""
    var conversionFactor: Int = 1
    var volumeOutput: String = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add new drink" //Sets title
        
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        // Sets picker data items
        pickerData = ["ml", "cl", "l"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        unitChosen = pickerData[row]
    }
    @IBAction func onPress(_ sender: Any) {
        if let volume = self.volumeInput.text {
            if let volumeInt = Int(volume){
                if unitChosen == "cl" {
                    conversionFactor = 10
                } else if unitChosen == "l" {
                    conversionFactor = 1000
                }
                volumeOutput = String(volumeInt*conversionFactor)
                print(volumeOutput)
            }
        }
    }
    
}

