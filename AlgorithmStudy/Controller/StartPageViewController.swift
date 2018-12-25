//
//  StartPageViewController.swift
//  AlgorithmStudy
//
//  Created by Junwoo Seo on 11/5/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import UIKit

class StartPageViewController: UIViewController {

    @IBOutlet weak var algoLabel: UILabel!
    @IBOutlet weak var studyButton: UIButton!
    @IBOutlet weak var quizButton: UIButton!
    
    var algoModel = AlgorithmModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        algoLabel.adjustsFontSizeToFitWidth = true
        studyButton.titleLabel?.adjustsFontSizeToFitWidth = true
        quizButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
