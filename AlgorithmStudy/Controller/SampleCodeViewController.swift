//
//  SampleCodeViewController.swift
//  AlgorithmStudy
//
//  Created by Junwoo Seo on 12/4/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import UIKit

class SampleCodeViewController: UIViewController {

    var currentIndexPath = IndexPath()
    let algoModel = AlgorithmModel()

    @IBOutlet weak var AlgorithmCode: UITextView!
    
//    override func viewDidLoad() {
//        let attributedString = NSMutableAttributedString(string: "Want to learn iOS? You should visit the best source of free iOS tutorials!")
//        attributedString.addAttribute(.link, value: "https://www.hackingwithswift.com", range: NSRange(location: 19, length: 55))
//
//        textView.attributedText = attributedString
//    }
//
//    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
//        UIApplication.shared.open(URL, options: [:])
//        return false
//    }
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let doc = String(algoModel.getSampleCode(section: currentIndexPath.section, row: currentIndexPath.row))
        let doc1 = doc.replacingOccurrences(of: "\\n", with: "\n")
        let doc2 = doc1.replacingOccurrences(of: "\\t", with: "\t")
        AlgorithmCode.text = doc2
        AlgorithmCode.backgroundColor = UIColor.darkGray
        AlgorithmCode.textColor = UIColor.white
        
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
