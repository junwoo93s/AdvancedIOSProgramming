//
//  ViewController.swift
//  AlgorithmStudy
//
//  Created by Junwoo Seo on 10/28/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var algoModel = AlgorithmModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let all = algoModel.Algorithms
        print(all)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

