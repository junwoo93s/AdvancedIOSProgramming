//
//  TestViewController.swift
//  PSUwalk
//
//  Created by Junwoo Seo on 10/28/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import UIKit

class TestViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var testView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        scrollView.addSubview(testView)
        self.view.addSubview(scrollView)
        scrollView.contentSize = testView.bounds.size


        // Do any additional setup after loading the view.
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
