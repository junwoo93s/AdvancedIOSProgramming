//
//  AlgorithmTableViewController.swift
//  AlgorithmStudy
//
//  Created by Junwoo Seo on 11/5/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import UIKit

class AlgorithmTableViewController: UITableViewController{

    //MARK: - Global Variables
    
    var buttonTag = 0
    let algoModel = AlgorithmModel()
    var currentSelectedIndexPAth = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Action Outlet
    
    @IBAction func CancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return algoModel.AllSectionTitleInArray().count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let returnValue = algoModel.RowNumberSectionTitle(index: section)

        return returnValue
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlgoCell", for: indexPath)
        let infoOfAlgorithm = algoModel.infoForEachRow(section: indexPath.section, row: indexPath.row)
        cell.textLabel!.text = infoOfAlgorithm.name
//        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle(rawValue: "Noteworthy"))
         cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.font = UIFont(name: "Noteworthy", size:22);

        let checkButton = UIButton(type: .custom)
        checkButton.tag = buttonTag
        buttonTag = buttonTag + 1
        checkButton.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        checkButton.addTarget(self, action: #selector(CheckButtonPressed(sender:)), for: .touchUpInside)
        checkButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        
//        cell.accessoryView = checkButton

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = algoModel.AllSectionTitleInArray()[section]
        return title
    }
 
    
    @objc func CheckButtonPressed(sender:UIButton){
        if sender.currentImage == #imageLiteral(resourceName: "unchecked"){
            sender.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        }
        else{
            sender.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSelectedIndexPAth = indexPath
        performSegue(withIdentifier: "ToInfo", sender: self)
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue)
        switch segue.identifier {
        case "ToInfo":
//            let navController = segue.destination as! UINavigationController
            let infoViewController = segue.destination as! InfoViewController
//            let infoViewController = navController.topViewController as! InfoViewController
            infoViewController.indexPathOfCurrent = currentSelectedIndexPAth
        case "backToMain":
            _ = segue.destination 
            
        default:
            assert(false, "Unhandled Segue")
        }
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
