//
//  InfoViewController.swift
//  AlgorithmStudy
//
//  Created by Junwoo Seo on 11/5/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import UIKit


extension String {
    var isInt: Bool {
        return Int(self) != nil
    }

}

extension Int {
    var isEven: Bool{
        if self%2 == 0{
            return true
        }
        return false
    }
}



class InfoViewController: UIViewController, UITextFieldDelegate {
    
   
    
    
    


    
    //MARK: -action outlets
    
    @IBAction func CancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        CustomizeTextField.resignFirstResponder()
        
    }
    
    @IBAction func ResetButtonPressed(_ sender: Any) {
        
        
        
        UIView.animate(withDuration: 1.0) {
            self.firstBox.frame.origin = self.ResetPoints[0]
            self.secondBox.frame.origin = self.ResetPoints[1]
            self.thirdBox.frame.origin = self.ResetPoints[2]
            self.forthBox.frame.origin = self.ResetPoints[3]
            self.fixBox.frame.origin = self.ResetPoints[4]
            self.sortingBox = [self.firstBox,self.secondBox,self.thirdBox,self.forthBox,self.fixBox]
            self.heightAdjustment()
        }
        
        
    }
    
    func LinkedCustomTextFieldShowing(){
        CustomizeTextField.text = ""
//        CustomizeTextField.becomeFirstResponder()
        if currentAlgorithmName.contains("Tree") == false && currentAlgorithmName.contains("Hash Table") == false && self.currentAlgorithmName.contains("Searching") == false{
            CustomizeTextField.frame.origin.y = CGFloat(self.animationRootView.frame.height / 5) - CGFloat(self.CustomizeTextField.frame.height / 2)
        }
        UIView.animate(withDuration: 0.8) {
            self.CustomizeTextField.isHidden = false
            let xPoint = CGFloat(self.animationRootView.frame.width / 2)
            if self.currentAlgorithmName.contains("Tree") == false && self.currentAlgorithmName.contains("Hash Table") == false && self.currentAlgorithmName.contains("Searching") == false{
                let yPoint = CGFloat(self.animationRootView.frame.height / 5)
                self.CustomizeTextField.center = CGPoint(x: xPoint, y: yPoint)
            }
            else{
                self.CustomizeTextField.center = CGPoint(x: xPoint, y: self.CustomizeTextField.frame.height/2)
            }
        }
    }
    
    func LinkedCustomTextFieldHiding(){
        UIView.animate(withDuration: 0.8, animations: {
            self.CustomizeTextField.alpha = 0.3
            let xPoint = CGFloat(self.animationRootView.frame.width)
            self.CustomizeTextField.frame.origin.x = xPoint
            
        }) { (true) in
            self.CustomizeTextField.isHidden = true
            self.CustomizeTextField.alpha = 1
            self.CustomizeTextField.resignFirstResponder()
        }


    }
    
    
    //in LinkedList = Searching
    @IBAction func BackButtonPressed(_ sender: Any) {
        if currentType == "sorting"{
            isPrev = true
            if currentType == "sorting" && isPrev == true{
                whichSortingReverse(currentAlgirthmName: currentAlgorithmName)
            }
        }
        else if currentType == "Linked List"{
            if CustomizeTextField.isHidden == true{
                LinkedCustomTextFieldShowing()
                NextButton.isEnabled = false
                SolveButton.isEnabled = false
            }
            else{
                LinkedCustomTextFieldHiding()
                NextButton.isEnabled = true
                SolveButton.isEnabled = true
                if CustomizeTextField.text != ""{
                    LinkedSearching()
                }
            }
        }
        else if currentType == "Tree"{
            if CustomizeTextField.isHidden == true{
                LinkedCustomTextFieldShowing()
                NextButton.isEnabled = false
                SolveButton.isEnabled = false
            }
            else{
                LinkedCustomTextFieldHiding()
                NextButton.isEnabled = true
                SolveButton.isEnabled = true
                if CustomizeTextField.text != ""{
                    TreeSearching()
                }
                
            }
        }
        else if currentType == "Hash Table"{
            if CustomizeTextField.isHidden == true{
                LinkedCustomTextFieldShowing()
                NextButton.isEnabled = false
                SolveButton.isEnabled = false
            }
            else{
                LinkedCustomTextFieldHiding()
                NextButton.isEnabled = true
                SolveButton.isEnabled = true
                if CustomizeTextField.text != ""{
                    HashSearching()
                }
                
            }
        }

    }
    
    
    //in LinkedList = Inserting
    @IBAction func NextButtonPressed(_ sender: Any) {
        isNext = true
        BackButton.isEnabled = true
        if currentType == "sorting"{
            whichSorting(currentAlgirthmName: currentAlgorithmName)
        }
        else if currentType == "Linked List"{
            if CustomizeTextField.isHidden == true{
                LinkedCustomTextFieldShowing()
                BackButton.isEnabled = false
                SolveButton.isEnabled = false
            }
            else{
                LinkedCustomTextFieldHiding()
                BackButton.isEnabled = true
                SolveButton.isEnabled = true
                if CustomizeTextField.text != ""{
                    LinkedInserting()
                }
                if LinkedListBox.count == 5{
                    NextButton.isEnabled = false
                    NextButton.setTitleColor(UIColor.gray, for: .normal)
                }
            }
        }
        else if currentType == "Tree"{
            if CustomizeTextField.isHidden == true{
                LinkedCustomTextFieldShowing()
                BackButton.isEnabled = false
                SolveButton.isEnabled = false
            }
            else{
                LinkedCustomTextFieldHiding()
                BackButton.isEnabled = true
                SolveButton.isEnabled = true
                if CustomizeTextField.text != ""{
                    TreeInserting()
                }
            }
        }
        else if currentType == "Hash Table"{
            if CustomizeTextField.isHidden == true{
                LinkedCustomTextFieldShowing()
                BackButton.isEnabled = false
                SolveButton.isEnabled = false
            }
            else{
                LinkedCustomTextFieldHiding()
                BackButton.isEnabled = true
                SolveButton.isEnabled = true
                if CustomizeTextField.text != ""{
                    HashInserting()
                }
            }
        }
        
    }
    
    //in LinkedList = Deleting
    @IBAction func SolveButtonPressed(_ sender: Any) {
        if currentType == "sorting"{
            if currentAlgorithmName.contains("Bubble Sort"){
                mergeCount = 0
            }
            whichSorting(currentAlgirthmName: currentAlgorithmName)
            
        }
        else if currentType == "Linked List"{
            if CustomizeTextField.isHidden == true{
                BackButton.isEnabled = false
                NextButton.isEnabled = false
                LinkedCustomTextFieldShowing()
            }
            else{
                LinkedCustomTextFieldHiding()
                BackButton.isEnabled = true
                NextButton.isEnabled = true
                if CustomizeTextField.text != ""{
                    LinkedDeleting()
                }
            }
        }
        else if currentType == "Tree"{
            if CustomizeTextField.isHidden == true{
                BackButton.isEnabled = false
                NextButton.isEnabled = false
                LinkedCustomTextFieldShowing()
            }
            else{
                LinkedCustomTextFieldHiding()
                BackButton.isEnabled = true
                NextButton.isEnabled = true
                if CustomizeTextField.text != ""{
                    TreeDeleting()
                }
            }
        }
        else if currentType == "Hash Table"{
            if CustomizeTextField.isHidden == true{
                BackButton.isEnabled = false
                NextButton.isEnabled = false
                LinkedCustomTextFieldShowing()
            }
            else{
                LinkedCustomTextFieldHiding()
                BackButton.isEnabled = true
                NextButton.isEnabled = true
                if CustomizeTextField.text != ""{
                    HashDeleting()
                }
            }
        }
        
    }
    
    
    
    //MARK: -textfield
    func textFieldDidEndEditing(_ textField: UITextField) {
        if currentType == "sorting"{
            if textField.text != ""{
                sortingCustomizeVariables = textField.text!.components(separatedBy: ",")
                if sortingCustomizeVariables.count != 5{
                    let alert = UIAlertController(title: "Customizing", message: "5 variables have to 1<x<9", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "close", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
                else{
                    for variables in sortingCustomizeVariables{
                        if Int(variables)!>9 && Int(variables)!<1{
                            let alert = UIAlertController(title: "Customizing", message: "5 variables have to 1<x<9", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "close", style: .cancel, handler: nil))
                            self.present(alert, animated: true)
                        }
                    }
                }
            }
        }
        else if currentType == "Tree"{
            if textField.text == ""{
                textField.resignFirstResponder()
            }
            else{
                if (textField.text?.isInt)! == true && Int((textField.text)!)! < 10{
                    LinkedCurrentSearchingNumber = Int(textField.text!)!
                }
                else{
                    textField.becomeFirstResponder()
                }
            }

        }
        else if currentType == "Linked List"{
            if textField.text == ""{
                textField.resignFirstResponder()
            }
            else{
                if (textField.text?.isInt)! == true && Int((textField.text)!)! < 100{
                    LinkedCurrentSearchingNumber = Int(textField.text!)!
                }
                else{
                    textField.becomeFirstResponder()
                }
            }

        }

    }
    

    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        textField.becomeFirstResponder()
//        return true
//    }
    
    
    //MARK: - Tree outlets
    
    @IBOutlet weak var TreeRootBox: UIView!
    @IBOutlet weak var TreeRootBoxText: UILabel!
    @IBOutlet weak var TreeLeftToRight: UIImageView!
    @IBOutlet weak var TreeRightToLeft: UIImageView!
    @IBOutlet weak var TreeRootLeftBox: UIView!
    @IBOutlet weak var TreeRootLeftBoxText: UILabel!
    @IBOutlet weak var TreeRootRightBox: UIView!
    @IBOutlet weak var TreeRootRightBoxText: UILabel!
    
    
    
    //MARK: - LinkedList outlets
    
    @IBOutlet weak var LinkedFirstBox: UIView!
    @IBOutlet weak var LinkedFirstBoxText: UILabel!
    @IBOutlet weak var LinkedSecondBox: UIView!
    @IBOutlet weak var LinkedSecondBoxText: UILabel!

    
    @IBOutlet weak var firstDoubleArrow: UIImageView!
    @IBOutlet weak var firstArrow: UIImageView!

    
    
    //MARK: - sorting outlets
    @IBOutlet weak var firstBox: UIView!
    @IBOutlet weak var secondBox: UIView!
    @IBOutlet weak var thirdBox: UIView!
    @IBOutlet weak var forthBox: UIView!
    @IBOutlet weak var fixBox: UIView!
    
    @IBOutlet weak var CustomizeTextField: UITextField!
    @IBOutlet weak var AlgorithmTitle: UILabel!
    @IBOutlet weak var realLifeExample: UITextView!
    @IBOutlet weak var timeOrAction: UILabel!
    @IBOutlet weak var bestOrSearch: UILabel!
    @IBOutlet weak var averageOrInsertion: UILabel!
    @IBOutlet weak var worstOrDeletion: UILabel!
    @IBOutlet weak var spaceComplexity: UILabel!
    
    @IBOutlet weak var ResetButton: UIButton!
    
    @IBOutlet weak var BackButton: UIButton!
    
    @IBOutlet weak var NextButton: UIButton!
    
    @IBOutlet weak var SolveButton: UIButton!
    
    @IBOutlet weak var animationRootView: UIView!
    
    @IBOutlet weak var CustomButton: UIButton!
    
    @IBAction func CustomButtonPressed(_ sender: Any) {
        if CustomButton.titleLabel!.text == "Customize Variables"{
            self.CustomButton.setTitle("Done", for: .normal)
//            self.CustomizeTextField.becomeFirstResponder()
            CustomizeTextField.text = ""
            UIView.animate(withDuration: 0.8) {
                self.CustomizeTextField.isHidden = false
                self.CustomizeTextField.frame.origin = CGPoint(x: 0.0, y: 0.0)
                
            }
        }
        else{
            if CustomizeTextField.text != ""{
                sortingCustomizeVariables = CustomizeTextField.text!.components(separatedBy: ",")
                if sortingCustomizeVariables.count == 5{
                    var counter = 0
                    for variables in sortingCustomizeVariables{
                        if Int(variables)!>9 || Int(variables)!<1{
                            let alert = UIAlertController(title: "Customizing", message: "5 variables have to 1<x<9", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "close", style: .cancel, handler: nil))
                            self.present(alert, animated: true)
                            self.CustomizeTextField.text = ""
                        }
                        else{
                            counter+=1
                        }
                    }
                    if counter == 5{
                        self.CustomButton.setTitle("Customize Variables", for: .normal)
                        UIView.animate(withDuration: 0.8, animations: {
                            self.CustomizeTextField.alpha = 0.3
                            self.CustomizeTextField.frame.origin = self.CustomButton.frame.origin
                        }) { (true) in
                            self.CustomizeTextField.isHidden = true
                            self.CustomizeTextField.alpha = 1
                            self.CustomizeTextField.resignFirstResponder()
                            self.changeHeight()
                        }
                    }
                    else{
                        self.CustomizeTextField.text = ""
                    }
                }
                else if sortingCustomizeVariables.count != 5{
                    let alert = UIAlertController(title: "Customizing", message: "5 variables have to 1<x<9", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "close", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    self.CustomizeTextField.text = ""

                }
                else{
                    for variables in sortingCustomizeVariables{
                        if Int(variables)!>9 && Int(variables)!<1{
                            let alert = UIAlertController(title: "Customizing", message: "5 variables have to 1<x<9", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "close", style: .cancel, handler: nil))
                            self.present(alert, animated: true)
                            self.CustomizeTextField.text = ""

                        }
                    }
                }
            }
            else if CustomizeTextField.text == ""{
                self.CustomButton.setTitle("Customize Variables", for: .normal)
                UIView.animate(withDuration: 0.8, animations: {
                    self.CustomizeTextField.alpha = 0.3
                    self.CustomizeTextField.frame.origin = self.CustomButton.frame.origin
                }) { (true) in
                    self.CustomizeTextField.isHidden = true
                    self.CustomizeTextField.alpha = 1
//                    self.changeHeight()
                }
            }
            
            
        }
    }
    //MARK: -Tree Animation
    
    
    
    
    //MARK: -Linked List Searching Animation
 
    
    //MARK: - Sorting Animation
    func changeHeight(){
        var index = 0
        for box in sortingBox{
            let width = box.frame.width
            box.frame.size = CGSize(width: width, height: CGFloat(Int(sortingCustomizeVariables[index])!*10))
            index += 1
            
        }
        heightAdjustment()
    }
    
    
    func heightAdjustment(){
        let heightOfAnimationView = animationRootView.bounds.height
        let yLocationForBox = ((heightOfAnimationView / 4) * 3 )
        let yPoint = CGFloat(yLocationForBox)
        firstBox.frame.origin.y = yPoint
        firstBox.frame.origin.y = yPoint - firstBox.bounds.height

        secondBox.frame.origin.y = yPoint
        secondBox.frame.origin.y = yPoint - secondBox.bounds.height

        thirdBox.frame.origin.y = yPoint
        thirdBox.frame.origin.y = yPoint - thirdBox.bounds.height

        forthBox.frame.origin.y = yPoint
        forthBox.frame.origin.y = yPoint - forthBox.bounds.height

        fixBox.frame.origin.y = yPoint
        fixBox.frame.origin.y = yPoint - fixBox.bounds.height
//        fixBox.backgroundColor = seeingColor
        ResetPoints.append(firstBox.frame.origin)
        ResetPoints.append(secondBox.frame.origin)
        ResetPoints.append(thirdBox.frame.origin)
        ResetPoints.append(forthBox.frame.origin)
        ResetPoints.append(fixBox.frame.origin)
    }
    
    
    
    func whichSorting(currentAlgirthmName:String){
        if currentAlgorithmName.contains("Bubble Sort"){
            bubbleSort()
        }
        else if currentAlgorithmName.contains("Selection Sort"){
            selectionsort()
        }
        else if currentAlgorithmName.contains("Insertion Sort"){
            insertionSort()
        }
        else if currentAlgorithmName.contains("Merge Sort"){
            mergeSort()
        }
        else if currentAlgorithmName.contains("Quick Sort"){
            
        }
    }
    
    func whichSortingReverse(currentAlgirthmName:String){
        if currentAlgorithmName.contains("Bubble Sort"){
            bubbleSortReverse()
        }
        else if currentAlgorithmName.contains("Selection Sort"){
            selectionSortReverse()
        }
        else if currentAlgorithmName.contains("Insertion Sort"){
            insertionSortReverse()
        }
        else if currentAlgorithmName.contains("Merge Sort"){
            mergeSortReverse()
        }
        else if currentAlgorithmName.contains("Quick Sort"){
            
        }
    }
    

    
    
    func bubbleSort(){
        let length = sortingBox.count
        var delay = 0.0
        bubbleloop : for i in 0..<length{
            for j in 0..<(length-i-1){
                delay += 0.7
                if self.sortingBox[j].frame.height > self.sortingBox[j+1].frame.height
                {
                    UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                            self.sortingBox[j].backgroundColor = self.originalColor
                            self.sortingBox[j+1].backgroundColor = self.originalColor
                            let frontboxPoint = self.sortingBox[j].frame.origin.x
                            let backBoxPoint = self.sortingBox[j+1].frame.origin.x
                            self.lastMovedJ = j
                            self.lastMovedAnimation[j] = backBoxPoint
                            self.lastMovedAnimation[j+1] = frontboxPoint
                            self.sortingBox[j].frame.origin.x = backBoxPoint
                            self.sortingBox[j+1].frame.origin.x = frontboxPoint
                            self.sortingBox.swapAt(j, j+1)

                    })
                    {(true) in
                        if self.isNext == true{
                            self.isNext = false
                            self.BackButton.setTitleColor(UIColor.white, for: .normal)
                        }
                        else{
                            self.BackButton.setTitleColor(UIColor.gray, for: .normal)
                        }
                    }
                    if isNext == true{
                        break bubbleloop
                    }
                }
            }
        }
    }
    
    func bubbleSortReverse(){
        
        UIView.animate(withDuration: 1.0, delay: 0.8, options: [.beginFromCurrentState], animations: {
            self.sortingBox[self.lastMovedJ].frame.origin.x = self.lastMovedAnimation[self.lastMovedJ]!
            self.sortingBox[self.lastMovedJ+1].frame.origin.x = self.lastMovedAnimation[self.lastMovedJ+1]!
            self.sortingBox.swapAt(self.lastMovedJ, self.lastMovedJ+1)
        })
        if isPrev == true{
            isPrev = false
            BackButton.isEnabled = false
            BackButton.setTitleColor(UIColor.gray, for: .normal)
        }
    }
    


    
    //MARK: -insertion sort
    func insertionSort(){
        let length = sortingBox.count
        var delay = 0.0
        insertionloop : for i in 1..<length{
            let key = sortingBox[i]
            var j = i - 1
            delay += 0.3

            insideInsertLoop : while (j >= 0 && key.frame.height < sortingBox[j].frame.height){
                UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                    delay += 0.4
                    let frontboxPoint = self.sortingBox[j].frame.origin.x
                    let backboxPoint = self.sortingBox[j+1].frame.origin.x
                    
                    self.selectionSortInts[0] = (j)
                    self.selectionSortInts[1] = (j+1)
                    self.lastMovedAnimation[j] = frontboxPoint
                    self.lastMovedAnimation[j+1] = backboxPoint
                    
                    self.sortingBox[j+1].frame.origin.x = frontboxPoint
                    self.sortingBox[j].frame.origin.x = backboxPoint
                    self.sortingBox.swapAt(j+1, j)
                    j = j - 1
                })
                {(true) in
                    if self.isNext == true{
                        self.isNext = false
                        self.BackButton.setTitleColor(UIColor.white, for: .normal)
                    }
                    else{
                        self.BackButton.setTitleColor(UIColor.gray, for: .normal)
                    }
                }
                if isNext == true{
                    break insertionloop
                }
                
            }
            
        }
    }

    func insertionSortReverse(){
        UIView.animate(withDuration: 1.0, delay: 0.8, options: [.beginFromCurrentState], animations: {
            self.sortingBox[self.selectionSortInts[0]].frame.origin.x = self.lastMovedAnimation[self.selectionSortInts[1]]!
            self.sortingBox[self.selectionSortInts[1]].frame.origin.x = self.lastMovedAnimation[self.selectionSortInts[0]]!
            self.sortingBox.swapAt(self.selectionSortInts[0], self.selectionSortInts[1])
            //            self.selectionSortInts.remove(at: 0)
            //            self.selectionSortInts.remove(at: 1)
            
        })
        if isPrev == true{
            isPrev = false
            BackButton.isEnabled = false
            BackButton.setTitleColor(UIColor.gray, for: .normal)
        }
    }
    
    //MARK: -Merge Sort
    
    func mergeSortReverse(){
        if mergeCount <= 2{
            UIView.animate(withDuration: 1.0, delay: 0.8, options: [.beginFromCurrentState], animations: {
                self.sortingBox[self.selectionSortInts[0]].frame.origin.x = self.lastMovedAnimation[1]!
                self.sortingBox[self.selectionSortInts[1]].frame.origin.x = self.lastMovedAnimation[0]!
                self.sortingBox.swapAt(self.selectionSortInts[0], self.selectionSortInts[1])

            })
            if isPrev == true{
                isPrev = false
                BackButton.isEnabled = false
                BackButton.setTitleColor(UIColor.gray, for: .normal)
            }
            mergeCount -= 1
        }
        else if mergeCount <= 3{
            UIView.animate(withDuration: 1.0, delay: 0.8, options: [.beginFromCurrentState], animations: {
                self.thirdBox.frame.origin.x = self.mergeCountLocation3[0]!
                self.forthBox.frame.origin.x = self.mergeCountLocation3[1]!
                self.fixBox.frame.origin.x = self.mergeCountLocation3[2]!
                self.sortingBox = [self.mergeCountLocationOriginalPosition[0],self.mergeCountLocationOriginalPosition[1],self.mergeCountLocationOriginalPosition[2],self.mergeCountLocationOriginalPosition[3],self.mergeCountLocationOriginalPosition[4]] as! [UIView]
            })
            if isPrev == true{
                isPrev = false
                BackButton.isEnabled = false
                BackButton.setTitleColor(UIColor.gray, for: .normal)
            }
            mergeCount -= 1
        }
        else if mergeCount <= 4{
            UIView.animate(withDuration: 1.0, delay: 0.8, options: [.beginFromCurrentState], animations: {
                self.firstBox.frame.origin.x = self.mergeCountLocation3[0]!
                self.secondBox.frame.origin.x = self.mergeCountLocation3[1]!
                self.thirdBox.frame.origin.x = self.mergeCountLocation3[2]!
                self.forthBox.frame.origin.x = self.mergeCountLocation3[3]!
                self.fixBox.frame.origin.x = self.mergeCountLocation3[4]!

                self.sortingBox = [self.mergeCountLocationOriginalPosition[0],self.mergeCountLocationOriginalPosition[1],self.mergeCountLocationOriginalPosition[2],self.mergeCountLocationOriginalPosition[3],self.mergeCountLocationOriginalPosition[4]] as! [UIView]
            })
            if isPrev == true{
                isPrev = false
                BackButton.isEnabled = false
                BackButton.setTitleColor(UIColor.gray, for: .normal)
            }
            mergeCount -= 1
        }
    }
    func mergeSort(){
//        if mergeSortCount = 0
        var delay = 0.0
        
        if sortingBox[0].frame.height > sortingBox[1].frame.height{
            delay += 1.0
            
            UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {

                let frontboxPoint = self.sortingBox[0].frame.origin.x
                let backboxPoint = self.sortingBox[1].frame.origin.x
                
                self.selectionSortInts[0] = (0)
                self.selectionSortInts[1] = (1)
                self.lastMovedAnimation[0] = frontboxPoint
                self.lastMovedAnimation[1] = backboxPoint
                
                self.sortingBox[0].frame.origin.x = backboxPoint
                self.sortingBox[1].frame.origin.x = frontboxPoint
                self.sortingBox.swapAt(0, 1)
            })
            {(true) in
                if self.isNext == true{
                    self.isNext = false
                    self.BackButton.setTitleColor(UIColor.white, for: .normal)
                }
                else{
                    self.BackButton.setTitleColor(UIColor.gray, for: .normal)
                }
            }
        }
        if isNext == true && mergeCount == 0{
            mergeCount += 1
            return
        }
        
        delay += 1.0
        if sortingBox[2].frame.height > sortingBox[3].frame.height{
            
            UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                
                let frontboxPoint = self.sortingBox[2].frame.origin.x
                let backboxPoint = self.sortingBox[3].frame.origin.x
                
                self.selectionSortInts[0] = (2)
                self.selectionSortInts[1] = (3)
                self.lastMovedAnimation[0] = frontboxPoint
                self.lastMovedAnimation[1] = backboxPoint
                
                self.sortingBox[2].frame.origin.x = backboxPoint
                self.sortingBox[3].frame.origin.x = frontboxPoint
                self.sortingBox.swapAt(2, 3)
            })
            {(true) in
                if self.isNext == true{
                    self.isNext = false
                    self.BackButton.setTitleColor(UIColor.white, for: .normal)
                }
                else{
                    self.BackButton.setTitleColor(UIColor.gray, for: .normal)
                }
            }
        }
        if isNext == true && mergeCount == 1{
            mergeCount += 1
            return
        }
        
        mergeCountLocation3[0] = thirdBox.frame.origin.x
        mergeCountLocation3[1] = forthBox.frame.origin.x
        mergeCountLocation3[2] = fixBox.frame.origin.x
        var index = 0
        for box in sortingBox{
            mergeCountLocationOriginalPosition[index] = box
            index += 1
        }
        delay += 0.5
        for i in 2..<5{
            var minIndex = i
            for j in (minIndex+1..<5){
                delay += 0.5

                
                if self.sortingBox[minIndex].frame.height > self.sortingBox[j].frame.height
                {
                    if self.isNext == true{
                    }
                    minIndex = j
                }
            }
            if minIndex != i{
                UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {

                    let frontboxPoint = self.sortingBox[i].frame.origin.x
                    let backBoxPoint = self.sortingBox[minIndex].frame.origin.x
                    self.selectionSortInts[0] = (i)
                    self.selectionSortInts[1] = (minIndex)
                    self.lastMovedAnimation[i] = backBoxPoint
                    self.lastMovedAnimation[minIndex] = frontboxPoint
                    self.sortingBox[i].frame.origin.x = backBoxPoint
                    self.sortingBox[minIndex].frame.origin.x = frontboxPoint
                    self.sortingBox.swapAt(i, minIndex)
                    
                })
                {(true) in
                    if self.isNext == true{
                        self.isNext = false
                        self.BackButton.setTitleColor(UIColor.white, for: .normal)
                    }
                    else{
                        self.BackButton.setTitleColor(UIColor.gray, for: .normal)
                    }
                }
            }
        }
        if isNext == true && mergeCount == 2{
            mergeCount += 1
            return
        }
        
        mergeCountLocation3[0] = firstBox.frame.origin.x
        mergeCountLocation3[1] = secondBox.frame.origin.x
        mergeCountLocation3[2] = thirdBox.frame.origin.x
        mergeCountLocation3[3] = forthBox.frame.origin.x
        mergeCountLocation3[4] = fixBox.frame.origin.x
        
        var indexLast = 0
        for box in sortingBox{
            mergeCountLocationOriginalPosition[indexLast] = box
            indexLast += 1
        }
        for i in 0..<5{
            var minIndex = i
            for j in (minIndex+1..<5){
                delay += 0.5
                
                
                if self.sortingBox[minIndex].frame.height > self.sortingBox[j].frame.height
                {
                    if self.isNext == true{
                    }
                    minIndex = j
                }
            }
            if minIndex != i{
                UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                    
                    let frontboxPoint = self.sortingBox[i].frame.origin.x
                    let backBoxPoint = self.sortingBox[minIndex].frame.origin.x
                    self.selectionSortInts[0] = (i)
                    self.selectionSortInts[1] = (minIndex)
                    self.lastMovedAnimation[i] = backBoxPoint
                    self.lastMovedAnimation[minIndex] = frontboxPoint
                    self.sortingBox[i].frame.origin.x = backBoxPoint
                    self.sortingBox[minIndex].frame.origin.x = frontboxPoint
                    self.sortingBox.swapAt(i, minIndex)
                    
                })
                {(true) in
                    if self.isNext == true{
                        self.isNext = false
                        self.BackButton.setTitleColor(UIColor.white, for: .normal)
                    }
                    else{
                        self.BackButton.setTitleColor(UIColor.gray, for: .normal)
                    }
                }
            }
        }
        if isNext == true && mergeCount == 3{
            mergeCount += 1
            return
        }
        
        
        
    }
                
            
        
    
    
    
    //MARK: -Selection Sort:
    
    func selectionsort(){
        let length = sortingBox.count
        var delay = 0.0
        selectionloop : for i in 0..<length{
            var minIndex = i
            delay += 0.8
            for j in (minIndex+1..<length){
                
                if self.sortingBox[minIndex].frame.height > self.sortingBox[j].frame.height
                {
                    if self.isNext == true{
                    }
                        minIndex = j
                }
            }
            if minIndex != i{
                UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                    let frontboxPoint = self.sortingBox[i].frame.origin.x
                    let backBoxPoint = self.sortingBox[minIndex].frame.origin.x
                    self.selectionSortInts[0] = (i)
                    self.selectionSortInts[1] = (minIndex)
                    self.lastMovedAnimation[i] = backBoxPoint
                    self.lastMovedAnimation[minIndex] = frontboxPoint
                    self.sortingBox[i].frame.origin.x = backBoxPoint
                    self.sortingBox[minIndex].frame.origin.x = frontboxPoint
                    self.sortingBox.swapAt(i, minIndex)
                    
                })
                {(true) in
                    if self.isNext == true{
                        self.isNext = false
                        self.BackButton.setTitleColor(UIColor.white, for: .normal)
                    }
                    else{
                        self.BackButton.setTitleColor(UIColor.gray, for: .normal)
                    }
                }
                if isNext == true{
                    break selectionloop
                }
            }
        }
    }
    
    func selectionSortReverse(){
        UIView.animate(withDuration: 1.0, delay: 0.8, options: [.beginFromCurrentState], animations: {
            self.sortingBox[self.selectionSortInts[0]].frame.origin.x = self.lastMovedAnimation[self.selectionSortInts[0]]!
            self.sortingBox[self.selectionSortInts[1]].frame.origin.x = self.lastMovedAnimation[self.selectionSortInts[1]]!
            self.sortingBox.swapAt(self.selectionSortInts[0], self.selectionSortInts[1])
//            self.selectionSortInts.remove(at: 0)
//            self.selectionSortInts.remove(at: 1)

        })
        if isPrev == true{
            isPrev = false
            BackButton.isEnabled = false
            BackButton.setTitleColor(UIColor.gray, for: .normal)
        }
    }
    
    //MARK: -global variable for Search
    
    @IBOutlet weak var SearchFirstBox: UIView!
    @IBOutlet weak var SearchSecondBox: UIView!
    @IBOutlet weak var SearachThirdBox: UIView!
    @IBOutlet weak var SearchForthBox: UIView!
    @IBOutlet weak var SearchFifthBox: UIView!
    @IBOutlet weak var SearchSixthBox: UIView!
    @IBOutlet weak var SearchSeventhBox: UIView!
    @IBOutlet weak var SearchEigthBox: UIView!
    @IBOutlet weak var SearchNinthBox: UIView!
    @IBOutlet weak var SearchFirstBoxDownArrow: UIImageView!
    @IBOutlet weak var SearchFirstBoxRightArrow: UIImageView!
    @IBOutlet weak var SearchSecondBoxDownArrow: UIImageView!
    @IBOutlet weak var SearchThirdBoxLeftArrow: UIImageView!
    @IBOutlet weak var SearchForthBoxArrowDown: UIImageView!
    @IBOutlet weak var SearchFifthBoxLeftArrow: UIImageView!
    @IBOutlet weak var SearchFifthBoxRightArrow: UIImageView!
    @IBOutlet weak var SearchSixthBoxUpArrow: UIImageView!
    @IBOutlet weak var SearchSeventhBoxLeftArrow: UIImageView!
    @IBOutlet weak var SearchEighthBoxRightArrow: UIImageView!
    @IBOutlet weak var SearchNinthBoxUpArrow: UIImageView!
    var SearchSteps = [Int:[Int]]()
    var SearchArrowsOrder = [Int:[UIImageView]]()
    var SearchBoxOrders = [UIView]()
    
    
    //MARK: -global variable for tree
    var TreeBoxSize = CGSize()
    var TreeLineSize = CGSize()
    var TreeBox = [Int:UIView]()
    var TreeBoxText = [Int:UILabel]()
    var TreeLines = [Int:UIImageView]()
    var TreeLineToRight = UIImageView()
    var TreeLineToLeft = UIImageView()
    var TreeRootPoint = CGPoint()
    var TreeDecendent = [Int]()
    
    
    //MARK: - global variable for hash table
    
    @IBOutlet weak var HashFirstBox: UIView!
    @IBOutlet weak var HashFirstBoxText: UILabel!
    @IBOutlet weak var HashSecondBox: UIView!
    @IBOutlet weak var HashSecondBoxText: UILabel!
    @IBOutlet weak var HashThridBox: UIView!
    @IBOutlet weak var HashThirdBoxText: UILabel!
    @IBOutlet weak var HashForthBox: UIView!
    @IBOutlet weak var HashForthBoxText: UILabel!
    @IBOutlet weak var HashFifthBox: UIView!
    @IBOutlet weak var HashFifthBoxText: UILabel!
    var HashRootBox = [Int : [UIView]]()
    var HashRootBoxText = [Int : [UILabel]]()
    var HashRootArrowBox = [Int : [UIImageView]]()
    var HashBoxSize = CGSize()
    var HashTextSize = CGSize()
    
    
    
    //MARK: -global variable for linked list
    var LinkedListBox = [UIView]()
    var LinkedListArrowBox = [UIImageView]()
    var LinkedListBoxText = [UILabel]()
    var LinkedCurrentSearchingNumber = Int()
    var LinkedBoxSize = CGSize()
    var LinkedArrowSize = CGSize()
    var LinkedFontSize = CGSize()
    var LinkedArrowPoint = CGPoint()
    var LinkedBoxPoint = CGPoint()
    var LinkedBoxDistance = CGFloat()
    
    
    //MARK: -global variable
    var mergeCountLocationOriginalPosition = [Int:UIView]()
    var mergeCountLocation3 = [Int:CGFloat]()
    var mergeCount = Int()
    var lastMovedAnimation = [Int:CGFloat]()
    var lastMovedJ = Int()
    var selectionSortInts = [0,0]
    var isPrev = Bool()
    var isNext = Bool()
    var animationsSaved = [CAAnimation]()
    var originalColor = UIColor()
    var currentAlgorithmName = String()
    let algoModel = AlgorithmModel()
    var indexPathOfCurrent = IndexPath()
    var seeingColor = UIColor(red: 0.8784, green: 0.3922, blue: 0.651, alpha: 1)
    var currentType = String()
    var sortingBox = [UIView]()
    var sortingCustomizeVariables = [String]()
    var ResetPoints = [CGPoint]()

    @objc func smapleCodeButton(){
        performSegue(withIdentifier: "toSampleCode", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let segmentBarItem = UIBarButtonItem(title: "Sample Code", style: .plain, target: self, action: #selector(smapleCodeButton))
        navigationItem.rightBarButtonItem = segmentBarItem
//        CustomizeTextField.delegate = self
        CustomButton.titleLabel?.adjustsFontSizeToFitWidth = true
        BackButton.titleLabel?.adjustsFontSizeToFitWidth = true
        ResetButton.titleLabel?.adjustsFontSizeToFitWidth = true
        NextButton.titleLabel?.adjustsFontSizeToFitWidth = true
        SolveButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        BackButton.setTitleColor(UIColor.gray, for: .normal)
        originalColor = firstBox.backgroundColor!
        CustomizeTextField.isHidden = true
        CustomizeTextField.delegate = self
        CustomizeTextField.autocorrectionType = .no
        CustomizeTextField.returnKeyType = .done
        if currentAlgorithmName.contains("sorting"){
            CustomizeTextField.keyboardType = UIKeyboardType.numberPad
        }
        else{
            CustomizeTextField.keyboardType = UIKeyboardType.numberPad
        }
        CustomizeTextField.textAlignment = .center
        addDoneButtonOnKeyboard()
//        CustomizeTextField.keybard

        
        
        TreeRootPoint = TreeRootBox.frame.origin
        TreeBoxSize = TreeRootBox.frame.size
        TreeLineSize = TreeLineToLeft.frame.size
        
        LinkedBoxSize = LinkedFirstBox.frame.size
        LinkedFontSize = LinkedFirstBoxText.frame.size
        
        LinkedBoxPoint = LinkedFirstBox.frame.origin
        LinkedBoxDistance = LinkedFirstBox.frame.origin.x - LinkedSecondBox.frame.origin.x

        print(indexPathOfCurrent)
        AlgorithmTitle.text = algoModel.titleForEachRow(section: indexPathOfCurrent.section, row: indexPathOfCurrent.row)
        AlgorithmTitle.adjustsFontSizeToFitWidth = true
        realLifeExample.text = algoModel.realLifeForEachRow(section: indexPathOfCurrent.section, row: indexPathOfCurrent.row)
        let type = algoModel.typeForEachRow(section: indexPathOfCurrent.section, row: indexPathOfCurrent.row)
        let timeOrActionOrSearch = algoModel.timeComplexForEachRow(section: indexPathOfCurrent.section, row: indexPathOfCurrent.row)
        let SpaceComplexity = algoModel.spaceComplexForEachRow(section: indexPathOfCurrent.section, row: indexPathOfCurrent.row)
        currentType = type
        currentAlgorithmName = type + "" + AlgorithmTitle.text!
        sortingBox = [firstBox, secondBox, thirdBox, forthBox, fixBox]
        if currentAlgorithmName.contains("Doubly Linked List"){
            LinkedArrowSize = firstDoubleArrow.frame.size
            LinkedArrowPoint = firstDoubleArrow.frame.origin
        }
        else{
            LinkedArrowSize = firstArrow.frame.size
            LinkedArrowPoint = firstArrow.frame.origin
        }
        if type != "sorting"{
            
            firstBox.isHidden = true
            secondBox.isHidden = true
            thirdBox.isHidden = true
            forthBox.isHidden = true
            fixBox.isHidden = true
        }
        else{
            CustomizeTextField.placeholder = "EX) 2,3,4,5,6"
            CustomizeTextField.keyboardType = .default
            BackButton.isEnabled = false
            

            firstBox.isHidden = false
            secondBox.isHidden = false
            thirdBox.isHidden = false
            forthBox.isHidden = false
            fixBox.isHidden = false
        }
        if type != "Linked List"{
            LinkedFirstBox.isHidden = true
            LinkedSecondBox.isHidden = true
            LinkedFirstBoxText.isHidden = true
            LinkedSecondBoxText.isHidden = true
            firstArrow.isHidden = true
            firstDoubleArrow.isHidden = true

        }
        else{
            ResetButton.isHidden = true
            LinkedListBox = [LinkedFirstBox,LinkedSecondBox]
            LinkedListBoxText = [LinkedFirstBoxText, LinkedSecondBoxText]
            LinkedFirstBox.isHidden = false
            LinkedSecondBox.isHidden = false
            LinkedFirstBoxText.isHidden = false
            LinkedSecondBoxText.isHidden = false
            
            if currentAlgorithmName.contains("Doubly"){
                firstDoubleArrow.isHidden = false
                firstArrow.isHidden = true
                LinkedListArrowBox = [firstDoubleArrow]

            }
            else{
                firstArrow.isHidden = false
                firstDoubleArrow.isHidden = true
                LinkedListArrowBox = [firstArrow]


            }
            BackButton.setTitle("Search", for: .normal)
            BackButton.setTitleColor(UIColor.white, for: .normal)
            NextButton.setTitle("Insert", for: .normal)
            SolveButton.setTitle("Delete", for: .normal)
            CustomButton.isHidden = true
        }
        if type != "Tree"{
            TreeRootBox.isHidden = true
            TreeRootBoxText.isHidden = true
            TreeLeftToRight.isHidden = true
            TreeRightToLeft.isHidden = true
            TreeRootLeftBox.isHidden = true
            TreeRootRightBox.isHidden = true
            TreeRootLeftBoxText.isHidden = true
            TreeRootRightBoxText.isHidden = true

        }
        else{
            ResetButton.isHidden = true
            TreeBox = [0:TreeRootBox,1:TreeRootLeftBox,2:TreeRootRightBox]
            TreeBoxText = [0:TreeRootBoxText,1:TreeRootLeftBoxText,2:TreeRootRightBoxText]
            TreeLineToLeft = TreeRightToLeft
            TreeLineToRight = TreeLeftToRight
            TreeLines = [1:TreeLineToLeft,2:TreeLineToRight]
            BackButton.setTitle("Search", for: .normal)
            BackButton.setTitleColor(UIColor.white, for: .normal)
            NextButton.setTitle("Insert", for: .normal)
            SolveButton.setTitle("Delete", for: .normal)
            CustomButton.isHidden = true
        }
        if type != "Hash Table"{
            HashFirstBox.isHidden = true
            HashFirstBoxText.isHidden = true
            HashSecondBox.isHidden = true
            HashSecondBoxText.isHidden = true
            HashThridBox.isHidden = true
            HashThirdBoxText.isHidden = true
            HashForthBox.isHidden = true
            HashForthBoxText.isHidden = true
            HashFifthBox.isHidden = true
            HashFifthBoxText.isHidden = true
        }
        else{
            ResetButton.isHidden = true

            HashRootBox = [0:[HashFirstBox], 1: [HashSecondBox], 2: [HashThridBox], 3: [HashForthBox], 4: [HashFifthBox]]
            HashRootBoxText = [0:[HashFirstBoxText], 1: [HashSecondBoxText], 2: [HashThirdBoxText], 3: [HashForthBoxText], 4: [HashFifthBoxText]]
            HashRootArrowBox = [0:[firstArrow], 1: [firstArrow], 2: [firstArrow], 3: [firstArrow], 4: [firstArrow]]
            BackButton.setTitle("Search", for: .normal)
            BackButton.setTitleColor(UIColor.white, for: .normal)
            NextButton.setTitle("Insert", for: .normal)
            SolveButton.setTitle("Delete", for: .normal)
            CustomButton.isHidden = true
            HashBoxSize = HashFirstBox.frame.size
            HashTextSize = HashFirstBoxText.frame.size
        }
        if type != "Searching"
        {
            SearchFirstBox.isHidden = true
            SearchSecondBox.isHidden = true
            SearachThirdBox.isHidden = true
            SearchForthBox.isHidden = true
            SearchFifthBox.isHidden = true
            SearchSixthBox.isHidden = true
            SearchSeventhBox.isHidden = true
            SearchEigthBox.isHidden = true
            SearchNinthBox.isHidden = true
            SearchFirstBoxDownArrow.isHidden = true
            SearchFirstBoxRightArrow.isHidden = true
            SearchSecondBoxDownArrow.isHidden = true
            SearchThirdBoxLeftArrow.isHidden = true
            SearchForthBoxArrowDown.isHidden = true
            SearchFifthBoxLeftArrow.isHidden = true
            SearchFifthBoxRightArrow.isHidden = true
            SearchSixthBoxUpArrow.isHidden = true
            SearchSeventhBoxLeftArrow.isHidden = true
            SearchEighthBoxRightArrow.isHidden = true
            SearchNinthBoxUpArrow.isHidden = true
        }
        else{
            ResetButton.isHidden = true
            SearchSteps = [1:[2,4],2:[5],3:[2],4:[7],5:[4,6],6:[3],7:[8],8:[9],9:[6]]
            SearchArrowsOrder = [1:[SearchFirstBoxDownArrow,SearchFirstBoxRightArrow],2:[SearchSecondBoxDownArrow],3:[SearchThirdBoxLeftArrow],4:[SearchForthBoxArrowDown],5:[SearchFifthBoxLeftArrow,SearchFifthBoxRightArrow],6:[SearchSixthBoxUpArrow],7:[SearchSeventhBoxLeftArrow],8:[SearchEighthBoxRightArrow],9:[SearchNinthBoxUpArrow]]
            SearchBoxOrders = [SearchFirstBox,SearchSecondBox,SearachThirdBox,SearchForthBox,SearchFifthBox,SearchSixthBox,SearchSeventhBox,SearchEigthBox,SearchNinthBox]
        }
        
        heightAdjustment()
        typeLabel(type: type, timeOrActionOrSearch: timeOrActionOrSearch, SpaceComplexity: SpaceComplexity)
        CustomizeTextField.frame.origin = CustomButton.frame.origin

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    @objc func keyboardWillShow(notification:Notification){
//        self.CustomizeTextField.becomeFirstResponder()
        self.CustomizeTextField.keyboardType = UIKeyboardType.numberPad
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameBeginUserInfoKey] as? CGRect
        //        let yPoint = editTextView.frame.origin.y + editTextView.frame.height
        //        let totalChangeHeight = UIScreen.main.bounds.height - yPoint
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y = -((keyboardSize?.height)! + (CustomizeTextField.inputAccessoryView?.frame.height)!)
            
        }
        else{
        }
    }
    @objc func keyboardWillHide(notification:Notification){
        //        editTextView.contentInset = UIEdgeInsets.zero
        //        let userInfo = notification.userInfo!
        //        let keyboardSize = userInfo[UIKeyboardFrameBeginUserInfoKey] as? CGRect
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y = 0
            //                +(keyboardSize?.height)!
            //            scrollView.contentSize = InsideScollView.frame.size
            
            CustomizeTextField.resignFirstResponder()
            
        }
        else{
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.view.resignFirstResponder()
    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if (text == "\n"){
//            textView.resignFirstResponder()
//        }
//        return true
//    }

//    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
//        CustomizeTextField.becomeFirstResponder()
//        return true
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: -swtich function for labeling
    func typeLabel(type : String, timeOrActionOrSearch : [[String]], SpaceComplexity : [String]){
        if type == "sorting"{
            timeOrAction.text = "Time Complexity"
            bestOrSearch.text = bestOrSearch.text! + timeOrActionOrSearch[0][1]
            averageOrInsertion.text = averageOrInsertion.text! + timeOrActionOrSearch[1][1]
            worstOrDeletion.text = worstOrDeletion.text! + timeOrActionOrSearch[2][1]
            
        }
        else if type == "Searching"{
            timeOrAction.text = "Graph Search Complexity"
            bestOrSearch.text = "Searching: " + timeOrActionOrSearch[0][1]
//            averageOrInsertion.isHidden = true
            worstOrDeletion.isHidden = true

        }
        else{
            timeOrAction.text = "Action Time Complexity"
            bestOrSearch.text = "Searching: " + timeOrActionOrSearch[0][1]
            averageOrInsertion.text = "Inserting: " + timeOrActionOrSearch[1][1]
            worstOrDeletion.text = "Deleting: " + timeOrActionOrSearch[2][1]

        }
        if type == "Searching"{
            averageOrInsertion.text = spaceComplexity.text! + SpaceComplexity[0]
            spaceComplexity.isHidden = true
            let difference = animationRootView.frame.origin.y - worstOrDeletion.frame.origin.y
            animationRootView.frame.origin = worstOrDeletion.frame.origin
            animationRootView.frame.size = CGSize(width: animationRootView.frame.width, height: animationRootView.frame.height + difference)
            CustomButton.isHidden = true
            CustomizeTextField.isHidden = true
            ResetButton.isHidden = true
            BackButton.isHidden = true
            NextButton.isHidden = true
            SolveButton.isHidden = true
            let xPoint = animationRootView.center.x
            let yPoint = ResetButton.center.y
            let searchButton = UIButton()
            searchButton.frame.size = BackButton.frame.size
            searchButton.setTitle("Search", for: .normal)
            searchButton.setTitleColor(UIColor.black, for: .normal)
            searchButton.center = CGPoint(x: xPoint, y: yPoint)
            searchButton.addTarget(self, action: #selector(SearchingFunction), for: .touchUpInside)
            searchButton.titleLabel?.adjustsFontSizeToFitWidth = true
            self.view.addSubview(searchButton)
            
        }
        else{
            spaceComplexity.text = spaceComplexity.text! + SpaceComplexity[0]

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "backToTable":
            _ = segue.destination as! AlgorithmTableViewController
            //            let infoViewController = navController.topViewController as! InfoViewController
            // AlgorithmTableViewController.indexPathOfCurrent = currentSelectedIndexPAth
        
        case "toSampleCode":
            let SampleCodeViewController = segue.destination as! SampleCodeViewController
            SampleCodeViewController.currentIndexPath = indexPathOfCurrent
            

        default:
            assert(false, "Unhandled Segue")
        }
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
                self.CustomizeTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.CustomizeTextField.resignFirstResponder()
        
    }

}
