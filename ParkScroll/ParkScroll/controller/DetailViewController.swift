//
//  DetailViewController.swift
//  ParkScroll
//
//  Created by Junwoo Seo on 10/8/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var DetailViewImage: UIImageView!
    @IBOutlet weak var DetailViewCaption: UILabel!
    
    var detailTitle = String()
    var detailImage = String()
    var detailCaption = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DetailViewImage.image = UIImage(named: detailImage)
        DetailViewCaption.text = detailCaption
        self.navigationItem.title = detailTitle
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
