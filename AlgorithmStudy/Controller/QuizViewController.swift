//
//  QuizViewController.swift
//  AlgorithmStudy
//
//  Created by Junwoo Seo on 11/27/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import UIKit

class QuizViewController: UITableViewController {

    
    
    @IBOutlet weak var TableView: UITableView!
    //multiple Question
    // ex) O(log n), O(n), O(n^2), O(nlogn)
        //sorting
            //time complexity questions
            //space complecity question
        //Tree, linked, hash
            //insert, deleting, searching question
        //Search
            //time and space for searching
    
        //showing time and space
            //insert the type of the algorithms
    
    
    //short answer Problems
        //showing time and space complexity
            //type what type of algorithms
        //showing animation
            //type what type of algorithms
        //showing
    //animation problems
        //user interaction by touching the box
    
    var numberOfProblems = Int()
    
    func multipleQuestions(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfProblems = 1
        TableView.delegate = self
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
