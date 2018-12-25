//
//  SortingProblemsViewController.swift
//  AlgorithmStudy
//
//  Created by Junwoo Seo on 12/4/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//


import UIKit
extension QuizForAlgoViewController{

    
    func sortingProblems(){
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
                if numberOfProblems == 14{
                    items = ["Bubble","Insertion","Selection","Merge"]
                }
                else{
                    items = ["O(n)","O(n^2)","O(1)","O(nlog(n))"]

                }
                
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
        lab.text = String(numberOfProblems) + ". what type of sorting algorithm is this animation"
        lab.frame.origin.x = problemOrigin.x
        lab.frame.origin.y = problemOrigin.y
        problemOrigin.y = problemOrigin.y + 50
        lab.adjustsFontSizeToFitWidth = true
        lab.font = UIFont(name: "Noteworthy", size:22);
        lab.frame.size = problemSize
        scrollView.addSubview(lab)
        numberOfProblems += 1
        sortingRootview.frame.origin = problemOrigin
        sortingRootview.center.x = scrollView.center.x
        var ans = UISegmentedControl()
        problemOrigin.y = problemOrigin.y + sortingRootview.frame.height
        ans = UISegmentedControl(items:["Selection","Merge","Insertion","Bubble"])
        ans.frame.origin.x = problemOrigin.x
        ans.frame.origin.y = problemOrigin.y
        problemOrigin.y = problemOrigin.y + 50
        ans.frame.size = CGSize(width: problemSize.width, height: problemSize.height/2)
        ans.apportionsSegmentWidthsByContent = true
        whatWereChoosed.append(ans)
        scrollView.addSubview(ans)
        randomGenerated = Int(arc4random_uniform(4))
        let candidate = ["Selection","Merge","Insertion","Bubble"]
        answers.append(candidate[randomGenerated])
        
        scrollView.addSubview(sortingRootview)
//        problemOrigin.y = problemOrigin.y + sortingRootview.frame.height
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
    
    @objc func submitButtonPressed(){
        var index = 0
        var correct = 0
        for x in whatWereChoosed{
            if x.selectedSegmentIndex <= 3 && x.selectedSegmentIndex >= 0{
                var temp = (String(x.titleForSegment(at: (x.selectedSegmentIndex))!))
                if currentIndexPath.section == 0{
                    if index == 12{
                        temp = temp + " Sort"
                    }
                }
                if answers[index] == temp{
                    correct += 1
                }
            }
            x.isEnabled = false
            index += 1
        }
        var check = true
        if currentIndexPath.section == 1{
            for x in linkedAnswers{
                if animationView[x].backgroundColor == originalColor{
                    print(x)
                    check = false
                }
            }
        }
        if currentIndexPath.section == 2{
            var convert = [1:1,2:0,3:1,5:2,6:0,7:2]
            let checkvalue = convert[linkedRandomGenerated+1]

            if animationView[checkvalue!].backgroundColor != UIColor.gray{
                check = false
            }
        }
        if currentIndexPath.section == 3{
            let checkValue = (linkedRandomGenerated + 1) % 5
            if animationView[checkValue].backgroundColor != UIColor.gray{
                check = false
            }
            
        }
        if currentIndexPath.section == 4{
            print(linkedRandomGenerated)
            let checkValues = searchEachNext[linkedRandomGenerated]
            for x in checkValues!{
                if x.backgroundColor != UIColor.gray{
                    check = false
                }
            }
            
        }
        if check == true{
            correct += 1
        }
        let alert = UIAlertController(title: "Grade", message: "\(correct)/\(numberOfProblems-1) is your Grade", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: { action in
            for x in self.whatWereChoosed{
                x.selectedSegmentIndex = -1
                x.isEnabled = true
            }
        }))
        self.present(alert, animated: true)
        if currentIndexPath.section == 0{
            animationView = [sortingFirstbox,sortingSecondBox,sortingThridBox,sortingForthBox,sortingFifthBox]
            heightAdjustment()
            var indexForBox = 0
            for point in originalPoint{
                animationView[indexForBox].frame.origin = point
                indexForBox += 1
            }
            answers.removeLast()
            randomGenerated = Int(arc4random_uniform(4))
            let candidate = ["Selection","Merge","Insertion","Bubble"]
            answers.append(candidate[randomGenerated])
            
        }
        if currentIndexPath.section == 1{
            for box in animationView{
                box.backgroundColor = originalColor
            }
            linkedAnswers = [Int]()
        }
        if currentIndexPath.section == 2{
            for box in animationView{
                box.backgroundColor = originalColor
            }
            
        }
        if currentIndexPath.section == 3{
            for box in animationView{
                box.backgroundColor = originalColor
            }
        }
        if currentIndexPath.section == 4{
            for box in animationView{
                box.backgroundColor = originalColor
            }
        }
        
    }
    
    func heightAdjustment()
    {
        let heightOfAnimationView = sortingRootview.bounds.height
        let yLocationForBox = ((heightOfAnimationView / 4) * 3 )
        let yPoint = CGFloat(yLocationForBox)
        sortingFirstbox.frame.origin.y = yPoint
        sortingFirstbox.frame.origin.y = yPoint - sortingFirstbox.bounds.height
        
        sortingSecondBox.frame.origin.y = yPoint
        sortingSecondBox.frame.origin.y = yPoint - sortingSecondBox.bounds.height
        
        sortingThridBox.frame.origin.y = yPoint
        sortingThridBox.frame.origin.y = yPoint - sortingThridBox.bounds.height
        
        sortingForthBox.frame.origin.y = yPoint
        sortingForthBox.frame.origin.y = yPoint - sortingForthBox.bounds.height
        
        sortingFifthBox.frame.origin.y = yPoint
        sortingFifthBox.frame.origin.y = yPoint - sortingFifthBox.bounds.height
    }
    
    func selectionSort()
    {
        let length = animationView.count
        var delay = 0.0
        selectionloop : for i in 0..<length
        {
            var minIndex = i
            delay += 0.8
            for j in (minIndex+1..<length){

                if self.animationView[minIndex].frame.height > self.animationView[j].frame.height
                {
                    minIndex = j
                }
            }
            if minIndex != i{
                UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                    let frontboxPoint = self.animationView[i].frame.origin.x
                    let backBoxPoint = self.animationView[minIndex].frame.origin.x
                    self.animationView[i].frame.origin.x = backBoxPoint
                    self.animationView[minIndex].frame.origin.x = frontboxPoint
                    self.animationView.swapAt(i, minIndex)

                })
                {(true) in
                }
            }
        }
    }
    
    func mergeSort(){
        var delay = 0.0
        
        if animationView[0].frame.height > animationView[1].frame.height{
            delay += 1.0
            
            UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                
                let frontboxPoint = self.animationView[0].frame.origin.x
                let backboxPoint = self.animationView[1].frame.origin.x
                self.animationView[0].frame.origin.x = backboxPoint
                self.animationView[1].frame.origin.x = frontboxPoint
                self.animationView.swapAt(0, 1)
            })
            {(true) in
            }
        }
        
        delay += 1.0
        if animationView[2].frame.height > animationView[3].frame.height{
            
            UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                
                let frontboxPoint = self.animationView[2].frame.origin.x
                let backboxPoint = self.animationView[3].frame.origin.x
                self.animationView[2].frame.origin.x = backboxPoint
                self.animationView[3].frame.origin.x = frontboxPoint
                self.animationView.swapAt(2, 3)
            })
            {(true) in
            }
        }
        delay += 0.5
        for i in 2..<5{
            var minIndex = i
            for j in (minIndex+1..<5){
                delay += 0.5
                
                
                if self.animationView[minIndex].frame.height > self.animationView[j].frame.height
                {
                    minIndex = j
                }
            }
            if minIndex != i{
                UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                    
                    let frontboxPoint = self.animationView[i].frame.origin.x
                    let backBoxPoint = self.animationView[minIndex].frame.origin.x
                    self.animationView[i].frame.origin.x = backBoxPoint
                    self.animationView[minIndex].frame.origin.x = frontboxPoint
                    self.animationView.swapAt(i, minIndex)
                    
                })
                {(true) in
                }
            }
        }
        for i in 0..<5{
            var minIndex = i
            for j in (minIndex+1..<5){
                delay += 0.5
                if self.animationView[minIndex].frame.height > self.animationView[j].frame.height
                {
                    minIndex = j
                }
            }
            if minIndex != i{
                UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                    
                    let frontboxPoint = self.animationView[i].frame.origin.x
                    let backBoxPoint = self.animationView[minIndex].frame.origin.x
                    self.animationView[i].frame.origin.x = backBoxPoint
                    self.animationView[minIndex].frame.origin.x = frontboxPoint
                    self.animationView.swapAt(i, minIndex)
                    
                })
                {(true) in
                }
            }
        }
    }
    func insertionSort(){
        let length = animationView.count
        var delay = 0.0
        insertionloop : for i in 1..<length{
            let key = animationView[i]
            var j = i - 1
            delay += 0.3
            
            insideInsertLoop : while (j >= 0 && key.frame.height < animationView[j].frame.height){
                UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                    delay += 0.4
                    let frontboxPoint = self.animationView[j].frame.origin.x
                    let backboxPoint = self.animationView[j+1].frame.origin.x
                    self.animationView[j+1].frame.origin.x = frontboxPoint
                    self.animationView[j].frame.origin.x = backboxPoint
                    self.animationView.swapAt(j+1, j)
                    j = j - 1
                })
                {(true) in
                }
                
            }
            
        }
    }
    func bubbleSort(){
        let length = animationView.count
        var delay = 0.0
        bubbleloop : for i in 0..<length{
            for j in 0..<(length-i-1){
                delay += 0.7
                if self.animationView[j].frame.height > self.animationView[j+1].frame.height
                {
                    UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                        let frontboxPoint = self.animationView[j].frame.origin.x
                        let backBoxPoint = self.animationView[j+1].frame.origin.x
                        self.animationView[j].frame.origin.x = backBoxPoint
                        self.animationView[j+1].frame.origin.x = frontboxPoint
                        self.animationView.swapAt(j, j+1)
                        
                    })
                    {(true) in
                    }
                }
            }
        }
    }
    
}
