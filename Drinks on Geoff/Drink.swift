//
//  Drink.swift
//  Drinks on Geoff
//
//  Created by Pearse Moloney on 03/11/2018.
//  Copyright © 2018 Pearse Moloney. All rights reserved.
//

//Aidan's fun code

import UIKit

struct Drink {
    var name: String
    var percentage: Float
    //var locations: [Coordinates]?
}

class instanceOfDrink {
    var drink: Drink
    var volume: Float
    var price: Float
    var numberOfDrinks: Int
    var image: UIImage?
    
    var relativeCheapness: Float
    
    init?(drink: Drink, volume: Float, price: Float, numberOfDrinks: Int, image: UIImage?) {
        self.drink = drink
        self.volume = volume
        self.price = price
        self.numberOfDrinks = numberOfDrinks
        self.image = image
        
        self.relativeCheapness = ((volume*Float(numberOfDrinks))*(drink.percentage/100))/price
    }
    
}

