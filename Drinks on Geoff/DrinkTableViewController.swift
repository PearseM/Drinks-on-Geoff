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
        loadSampleDrinks()
    }

    // MARK: - Table view data source

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "DrinkTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DrinkTableViewCell else {
            fatalError("The dequeued cell is not an instance of DrinkTableViewCell.")
        }

        let drink = drinks[indexPath.row]
        cell.nameLabel.text = drink.name
        cell.photoImageView.image = drink.image

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    private func loadSampleDrinks() {
        let photo1 = UIImage(named: "drink1")
        let photo2 = UIImage(named: "drink2")
        let photo3 = UIImage(named: "drink3")
        
        guard let drink1 = Drink(name: "Magners", volume: 1000, percentage: 4.5, price: 5, image: photo1) else {
            fatalError("Unable to instantiate drink1")
        }
        guard let drink2 = Drink(name: "Corona", volume: 330, percentage: 4.5, price: 4, image: photo2) else {
            fatalError("Unable to instantiate drink2")
        }
        guard let drink3 = Drink(name: "Smirnoff", volume: 1000, percentage: 37.5, price: 18, image: photo3) else {
            fatalError("Unable to instantiate drink1")
        }
        drinks += [drink1, drink2, drink3]
    }
    @IBAction func unwindToDrinkList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? DrinkViewController, let drink = sourceViewController.drink {
            let newIndexPath = IndexPath(row: drinks.count, section: 0)
            drinks.append(drink)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
}
