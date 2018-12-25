//
//  FavTableViewController.swift
//  PSUwalk
//
//  Created by Junwoo Seo on 10/14/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import UIKit



class FavTableViewController: UITableViewController {

    
    var isChecked = [Bool](repeating: false, count: 323)
    var FavData = [BuildingName]()
    var buttonTag = 0
//    var delegate : FavDelegate?
    var currentClicked = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return FavData.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Favorite", for: indexPath)
        cell.textLabel?.text = FavData[indexPath.row].name
//        let DeleteButton = UIButton(type: .custom)
//        DeleteButton.tag = buttonTag
//        currentClicked.append((cell.textLabel?.text)!)
//        buttonTag = buttonTag + 1
//        DeleteButton.setImage(#imageLiteral(resourceName: "trashcan"), for: .normal)
//        DeleteButton.addTarget(self, action: #selector(DeleteButtonPressed(sender:)), for: .touchUpInside)
//        DeleteButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//
//
//        cell.accessoryView = DeleteButton
        
        // Configure the cell...

        return cell
    }

    
//    @objc func DeleteButtonPressed(sender: UIButton){
//        print(sender.tag)
//        let currentName = (currentClicked[sender.tag])
//        FavData.remove(at: sender.tag)
//        buttonTag = 0
//        currentClicked = [String]()
//        delegate?.changeHeartButton(name: currentName, row: sender.tag)
//        tableView.reloadData()
//    }

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
