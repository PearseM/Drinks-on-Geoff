//
//  Drink.swift
//  Drinks on Geoff
//
//  Created by Pearse Moloney on 03/11/2018.
//  Copyright © 2018 Pearse Moloney. All rights reserved.
//

import UIKit

class Drink {
    var name: String
    var volume: Float
    var percentage: Float
    var price: Float
    var image: UIImage?
    var relativeExpense: Float
    //MARK: Initialisation
    init?(name: String, volume: Float, percentage: Float, price: Float, image: UIImage?) {
        if name.isEmpty || volume<=0 || percentage<=0 || price<=0 {
            return nil
        }
        self.name = name
        self.volume = volume
        self.percentage = percentage
        self.price = price
        self.image = image
        //Calculation to find its relative cost.
        self.relativeExpense = ((volume)*(percentage/100))/price
    }
}

