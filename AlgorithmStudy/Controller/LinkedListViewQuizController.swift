//
//  LinkedListViewQuizController.swift
//  AlgorithmStudy
//
//  Created by Junwoo Seo on 12/5/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import UIKit
import Foundation

extension QuizForAlgoViewController{
    func LinkedQuiz(){
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
                items = ["O(n)","O(n^2)","O(1)","O(nlog(n))"]
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
        lab.text = String(numberOfProblems) + ". what would shift to the left if \(linkedRandomGenerated+1) is deleted"
        for x in linkedRandomGenerated+1..<animationView.count{
            linkedAnswers.append(x)
        }
        lab.frame.origin.x = problemOrigin.x
        lab.frame.origin.y = problemOrigin.y
        problemOrigin.y = problemOrigin.y + 50
        lab.adjustsFontSizeToFitWidth = true
        lab.font = UIFont(name: "Noteworthy", size:22);
        lab.frame.size = problemSize
        scrollView.addSubview(lab)
        numberOfProblems += 1
        LinkedRootView.frame.origin = problemOrigin
        LinkedRootView.center.x = scrollView.center.x
        scrollView.addSubview(LinkedRootView)
        problemOrigin.y = problemOrigin.y + LinkedRootView.frame.height
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
