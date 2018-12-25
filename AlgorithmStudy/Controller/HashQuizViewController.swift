//
//  HashQuizViewController.swift
//  AlgorithmStudy
//
//  Created by Junwoo Seo on 12/6/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import Foundation
import UIKit

extension QuizForAlgoViewController{
    func HashQuiz(){
        let questions = (quizModel.infoForEachRow(section: currentIndexPath.section).type1)
        var question = 0
        for x in questions{
            if question % 2 == 0{
                let lab = UILabel()
                lab.text = String(numberOfProblems) + ". " + x
                lab.frame.origin.x = problemOrigin.x
                lab.frame.origin.y = problemOrigin.y
                lab.adjustsFontSizeToFitWidth = true
                lab.font = UIFont(name: "Noteworthy", size:22);
                lab.frame.size = problemSize
                scrollView.addSubview(lab)
                numberOfProblems += 1
            }
            else{
                let A = questions[question]
                answers.append(A)
                var Choice = UISegmentedControl()
                var items = [String]()
                items = ["O(n)","O(log(n))","O(1)","O(nlog(n))"]
                Choice = UISegmentedControl(items: items)
                Choice.frame.origin.x = problemOrigin.x
                Choice.frame.origin.y = problemOrigin.y
                Choice.frame.size = CGSize(width: problemSize.width, height: problemSize.height/2)
                Choice.apportionsSegmentWidthsByContent = true
                whatWereChoosed.append(Choice)
                scrollView.addSubview(Choice)
            }
            question += 1
            problemOrigin.y = problemOrigin.y + 50
            
            
        }
        let lab = UILabel()
        lab.text = String(numberOfProblems) + ". Where \(linkedRandomGenerated+1) should be stored ? select one"
        lab.frame.origin.x = problemOrigin.x
        lab.frame.origin.y = problemOrigin.y
        problemOrigin.y = problemOrigin.y + 50
        lab.adjustsFontSizeToFitWidth = true
        lab.font = UIFont(name: "Noteworthy", size:22);
        lab.frame.size = problemSize
        scrollView.addSubview(lab)
        numberOfProblems += 1
        hashRootView.frame.origin = problemOrigin
        hashRootView.center.x = scrollView.center.x
        scrollView.addSubview(hashRootView)
//
        problemOrigin.y = problemOrigin.y + hashRootView.frame.height
//
        let submitButton = UIButton()
        submitButton.frame.origin.x = problemOrigin.x
        submitButton.frame.origin.y = problemOrigin.y
        submitButton.frame.size = problemSize
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = UIColor.blue
        submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        scrollView.addSubview(submitButton)
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: problemOrigin.y + submitButton.frame.height + 10)
        
    }
}
