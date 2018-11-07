//
//  DrinkTableViewController.swift
//  Drinks on Geoff
//
//  Created by Pearse Moloney on 04/11/2018.
//  Copyright © 2018 Pearse Moloney. All rights reserved.
//

import UIKit

class DrinkTableViewController: UITableViewController {
    
    var drinks = [instanceOfDrink]()
    var drinktypes = [Drink]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Drinks on Geoff"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Table view data source

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkTableViewCell", for: indexPath) as? DrinkTableViewCell else {
            fatalError("The dequeued cell is not an instance of DrinkTableViewCell.")
        }

        let currentDrink = drinks[indexPath.row]
        cell.nameLabel.text = currentDrink.drink.name
        cell.photoImageView.image = currentDrink.image
        return cell
    }
    
    
    @IBAction func unwindToDrinkList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? DrinkViewController, let instanceOfDrink = sourceViewController.CurrentInstanceOfDrink, let drinkTypeToAdd = sourceViewController.instanceDrinkType  {
            
            addDrink(drinktoadd: instanceOfDrink)
            
            if (sourceViewController.isNewDrink){
                drinktypes.append(drinkTypeToAdd)
            }
            self.tableView.reloadData()
        }
    }


    func addDrink(drinktoadd: instanceOfDrink){
        
        let drinkToAdd = drinktoadd
        
        var index = 0
        
        var front: [instanceOfDrink] = []
        var back: [instanceOfDrink] = []
        
        var new_array: [instanceOfDrink] = []
        
        while (index < drinks.count) {
            if (drinkToAdd.relativeCheapness < drinks[index].relativeCheapness){
                front.append(drinks[index])
            } else{
                back.append(drinks[index])
            }
            index = index + 1
        }
        
        for x in front {
            new_array.append(x)
        }
        new_array.append(drinkToAdd)
        
        for x in back {
            new_array.append(x)
        }
        
        drinks = new_array
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DrinkViewController
        {
            let vc = segue.destination as? DrinkViewController
            vc?.drinkTypes = drinktypes
        }
    }
    
}
