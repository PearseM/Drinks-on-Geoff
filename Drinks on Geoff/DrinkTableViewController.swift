//
//  DrinkTableViewController.swift
//  Drinks on Geoff
//
//  Created by Pearse Moloney on 04/11/2018.
//  Copyright © 2018 Pearse Moloney. All rights reserved.
//

import UIKit

class DrinkTableViewController: UITableViewController {
    
    var drinks = [Drink]()
    
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

        let drink = drinks[indexPath.row]
        cell.nameLabel.text = drink.name
        cell.photoImageView.image = drink.image

        return cell
    }
    
    
    @IBAction func unwindToDrinkList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? DrinkViewController, let drink = sourceViewController.drink {
            addDrink(drinktoadd: drink)
            

            self.tableView.reloadData()
        }
    }


    func addDrink(drinktoadd: Drink){
        
        let drinkToAdd = drinktoadd
        
        var index = 0
        
        var front: [Drink] = []
        var back: [Drink] = []
        
        var new_array: [Drink] = []
        
        while (index < drinks.count) {
            if (drinkToAdd.relativeExpense < drinks[index].relativeExpense){
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
}
