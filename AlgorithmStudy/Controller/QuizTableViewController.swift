//
//  QuizTableViewController.swift
//  AlgorithmStudy
//
//  Created by Junwoo Seo on 12/4/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import UIKit

class QuizTableViewController: UITableViewController {

    var buttonTag = 0
    let algoModel = AlgorithmModel()
    var currentSelectedIndexPAth = IndexPath()
    
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
        return algoModel.AllSectionTitleInArray().count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let returnValue = algoModel.RowNumberSectionTitle(index: section)
        
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath)
        _ = algoModel.infoForEachRow(section: indexPath.section, row: indexPath.row)
        cell.textLabel!.text = algoModel.AllSectionTitleInArray()[indexPath.section]
//        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle(rawValue: "Noteworthy"))
        cell.textLabel?.font = UIFont(name: "Noteworthy", size:22);
        cell.textLabel?.adjustsFontSizeToFitWidth = true

        return cell
    }
 
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let title = algoModel.AllSectionTitleInArray()[section]
//        return title
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSelectedIndexPAth = indexPath
        performSegue(withIdentifier: "ToQuiz", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue)
        switch segue.identifier {
        case "ToQuiz":
            //            let navController = segue.destination as! UINavigationController
            let QuizForAlgoViewController = segue.destination as! QuizForAlgoViewController
            //            let infoViewController = navController.topViewController as! InfoViewController
            QuizForAlgoViewController.currentIndexPath = currentSelectedIndexPAth
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
