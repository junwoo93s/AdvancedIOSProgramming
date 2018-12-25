//
//  TreeViewController.swift
//  AlgorithmStudy
//
//  Created by Junwoo Seo on 11/30/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import UIKit

extension InfoViewController{
    func TreeGetParent(node : Int)->Int{
        if node != 0{
            return Int(floor((Double((node - 1) / 2))))
        }
        else{
            return 0
        }
    }
    
    func TreeGetAllDecendent(node: Int){
        if TreeHasLeftChild(node: node){
            let left = TreeGetLeftChild(node: node)
            //append node
            if TreeDecendent.contains(node) == false {
                TreeDecendent.append(node)
                
            }
            
            TreeGetAllDecendent(node: left)
        }
        if TreeHasRightChild(node: node){
            let right = TreeGetRightChild(node: node)
            //append node
            if TreeDecendent.contains(node) == false {
                TreeDecendent.append(node)
                
            }
            TreeGetAllDecendent(node: right)
        }
        if TreeHasLeftChild(node: node) == false && TreeHasRightChild(node: node) == false{
            //append
            if TreeDecendent.contains(node) == false {
                TreeDecendent.append(node)
                
            }
            
        }
    }
    func TreeGetHeight(node: Int)->Int{
        var height = 0
        var ascending = node
        let index = 0
        while index != ascending{
            ascending = TreeGetParent(node: ascending)
            height += 1
        }
        return height
    }
    
    
    func TreeGetLeftChild(node : Int)->Int{
        //        2r+1≤n
        return (2*node)+1
    }
    
    func TreeGetRightChild(node: Int)->Int{
        //        2r+2≤n
        return (2*node)+2
    }
    
    func TreeHasText(node: Int)->Bool{
        if TreeBox[node] != nil {
            return true
        }
        else{
            return false
        }
    }
    
    func TreeHasLeftChild(node: Int)->Bool{
        let value = TreeGetLeftChild(node: node)
        if TreeBox[value] == nil{
            return false
        }
        else{
            return true
        }
    }
    func TreeHasRightChild(node: Int)->Bool{
        let value = TreeGetRightChild(node: node)
        if TreeBox[value] == nil{
            return false
        }
        else{
            return true
        }
    }
    
    
    //true = left , false = right
    func TreeLeftOrRight(node: Int)->Bool{
        var currentNode = node
        while(currentNode != 1 && currentNode != 2){
            print("this while?")
            currentNode = TreeGetParent(node: currentNode)
        }
        if currentNode == 1{
            return true
        }
        else{
            return false
        }
    }
    
    func TreeOnlyHasLeftParent(node: Int)->Bool{
        let currentNode = node
        let parentNode = TreeGetParent(node: currentNode)
        let rightNodeOfParent = TreeGetRightChild(node: parentNode)
        if rightNodeOfParent == currentNode{
            return true
        }
        else{
            return false
        }
    }
    
    func TreeDeleting(){
        let deletingNumber = Int(CustomizeTextField.text!)!
        var delay = 0.0
        var index = 0
        var found = false
        UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
            while self.TreeBox[index] != nil{
                delay += 0.8
                if Int((self.TreeBoxText[index]?.text)!)! == deletingNumber{
                    self.TreeBox[index]?.backgroundColor = UIColor.orange
                    found = true
                    var checkRight = index
                    var firstCheck = 0
                    var checkLeft = index
                    checkRight = self.TreeGetRightChild(node: checkRight)
                    checkLeft = self.TreeGetLeftChild(node: checkLeft)
                    
                    //check if there are right child of the node. Then find the right node's leftest child and replace that node with the deleting node position.
                    if self.TreeBox[checkRight] != nil {
                        UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                            delay += 0.8
                            var checkLefty = checkRight
                            checkLefty = self.TreeGetLeftChild(node: checkLefty)
                            while self.TreeBox[checkLefty] != nil{
                                checkLefty = self.TreeGetLeftChild(node: checkLefty)
                            }
                            checkLefty = self.TreeGetParent(node: checkLefty)
                            self.TreeBox[checkLefty]?.backgroundColor = UIColor.orange
                            self.TreeLines[checkLefty]?.frame.origin.x = (self.TreeLines[checkLefty]?.frame.origin.x)! + self.animationRootView.frame.width
                            self.TreeBox[checkLefty]?.frame.origin = (self.TreeBox[index]?.frame.origin)!
                            firstCheck = checkLefty
                            self.TreeBox[index]?.frame.origin.x = (self.TreeBox[index]?.frame.origin.x)! + self.animationRootView.frame.width
                            
                        }, completion: { (true) in
                            self.TreeLines.removeValue(forKey: firstCheck)
                            self.TreeBox.removeValue(forKey: index)
                            self.TreeBoxText.removeValue(forKey: index)
                            let box = self.TreeBox[firstCheck]
                            let text = self.TreeBoxText[firstCheck]
                            self.TreeBox[index] = box
                            self.TreeBoxText[index] = text
                            self.TreeBox[firstCheck] = nil
                            self.TreeBoxText[firstCheck] = nil
                        })
                    }
                        //case when there are no right node so get the left node. Then just remove the left node of the deleting node.
                    else if self.TreeBox[checkLeft] != nil{
                        _ = checkLeft
                        _ = index
                        UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                            self.TreeDecendent.removeAll()
                            self.TreeGetAllDecendent(node: checkLeft)
                            print(self.TreeDecendent)
                            let xPoint = (self.TreeBox[index]?.frame.origin.x)! - (self.TreeBox[checkLeft]?.frame.origin.x)!
                            let yPoint = (self.TreeBox[index]?.frame.origin.y)! - (self.TreeBox[checkLeft]?.frame.origin.y)!
                            self.TreeBox[index]?.frame.origin.x = (self.TreeBox[index]?.frame.origin.x)! + self.animationRootView.frame.width
                            self.TreeBox[index] = nil
                            for node in self.TreeDecendent{
                                print("node is \(node)")
                                self.TreeBox[node]?.frame.origin.x = (self.TreeBox[node]?.frame.origin.x)! + xPoint
                                self.TreeBox[node]?.frame.origin.y = (self.TreeBox[node]?.frame.origin.y)! + yPoint
                                self.TreeLines[node]?.frame.origin.x = (self.TreeLines[node]?.frame.origin.x)! + xPoint
                                self.TreeLines[node]?.frame.origin.y = (self.TreeLines[node]?.frame.origin.y)! + yPoint
                                
                                let height = (self.TreeGetHeight(node: node))
                                let currentNode = node
                                if self.TreeLeftOrRight(node: currentNode){
                                    let value = Int(pow(Double(2), Double(height-1)))
                                    self.TreeBox[node - value] = self.TreeBox[node]
                                    if node-value == 0 || self.TreeOnlyHasLeftParent(node: node-value){
                                        self.TreeLines[node]?.frame.origin.x = (self.TreeLines[node]?.frame.origin.x)! + self.animationRootView.frame.width
                                        self.TreeLines[node] = nil
                                    }
                                    else{
                                        self.TreeLines[node - value] = self.TreeLines[node]
                                        self.TreeLines[node] = nil
                                    }
                                    self.TreeBoxText[node - value] = self.TreeBoxText[node]
                                    self.TreeBoxText[node] = nil
                                    self.TreeBox[node] = nil
                                }
                                else{
                                    let value = Int(pow(Double(2), Double(height-1))) + (2 * (height - 1))
                                    self.TreeBox[node - value] = self.TreeBox[node]
                                    if node-value == 0 || self.TreeOnlyHasLeftParent(node: node-value){
                                        self.TreeLines[node - value]?.frame.origin.x = (self.TreeLines[node - value]?.frame.origin.x)! + self.animationRootView.frame.width
                                        self.TreeLines[node - value] = nil
                                    }
                                    else{
                                        self.TreeLines[node - value] = self.TreeLines[node]
                                    }
                                    self.TreeBoxText[node - value] = self.TreeBoxText[node]
                                    self.TreeBoxText[node] = nil
                                    self.TreeBox[node] = nil
                                    self.TreeLines[node] = nil
                                    
                                }
                                
                            }
                            
                        }, completion: { (true) in
                            
                        })
                        
                    }
                        //case when there are no left or right node . Then just delete the node.
                    else{
                        print(index)
                        UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                            self.TreeBox[index]?.frame.origin.x = (self.TreeBox[index]?.frame.origin.x)! + self.animationRootView.frame.width
                            self.TreeLines[index]?.frame.origin.x = (self.TreeLines[index]?.frame.origin.x)! + self.animationRootView.frame.width
                        }, completion: { (true) in
                            self.TreeBox[index] = nil
                            self.TreeBoxText[index] = nil
                            self.TreeLines[index] = nil
                            
                        })
                    }
                    
                    break
                }
                else if Int((self.TreeBoxText[index]?.text)!)! > deletingNumber{
                    self.TreeBox[index]?.backgroundColor = UIColor.gray
                    index = self.TreeGetLeftChild(node: index)
                    
                }
                else{
                    self.TreeBox[index]?.backgroundColor = UIColor.gray
                    index = self.TreeGetRightChild(node: index)
                }
            }
        }){(true) in
            if found == true{
                print("whatsup")
                
            }
            for box in self.TreeBox{
                box.value.backgroundColor = self.originalColor
            }
        }
        
        
        
    }
    
    
    func TreeInserting(){
        let insertingNumber = Int(CustomizeTextField.text!)!
        var index = 0
        var beforeIndex = 0
        var delay = 0.0
        var found = true
        
        UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
            while self.TreeBox[index] != nil{
                delay += 0.8
                if Int((self.TreeBoxText[index]?.text)!)! == insertingNumber{
                    found = false
                    break
                }
                else if Int((self.TreeBoxText[index]?.text)!)! > insertingNumber{
                    self.TreeBox[index]?.backgroundColor = UIColor.gray
                    beforeIndex = index
                    
                    index = self.TreeGetLeftChild(node: index)
                    
                }
                else{
                    self.TreeBox[index]?.backgroundColor = UIColor.gray
                    beforeIndex = index
                    
                    index = self.TreeGetRightChild(node: index)
                }
                print(index)
            }
        }) { (true) in
            if self.TreeBox.count == 0{
                let box = UIView()
                box.backgroundColor = self.originalColor
                box.frame.size = self.TreeBoxSize
                box.frame.origin = self.TreeRootPoint
                box.frame.origin.x = box.frame.origin.x + self.animationRootView.frame.width
                let label = UILabel()
                label.text = String(insertingNumber)
                label.textColor = UIColor.black
                label.frame.size = self.LinkedFontSize
                self.animationRootView.addSubview(box)
                box.addSubview(label)
                label.center = box.convert(box.center, from:box.superview)
                UIView.animate(withDuration: 1.0, animations: {
                    let boxLocation = box.frame.origin.x - self.animationRootView.frame.width + box.frame.width
                    if boxLocation < self.animationRootView.frame.width{
                        box.frame.origin.x = box.frame.origin.x - self.animationRootView.frame.width
                        self.TreeBox[index] = box
                        self.TreeBoxText[index] = label
                    }
                    else{
                        self.animationRootView.willRemoveSubview(box)
                        
                    }
                    
                    
                }){(true) in
                    for box in self.TreeBox{
                        box.value.backgroundColor = self.originalColor
                    }
                }
            }
            else if found == true{
                _ = self.animationRootView.frame.origin.x
                //                let marginRightX = marginLeftX + self.animationRootView.frame.width
                //                let marginBottomY = self.animationRootView.frame.origin.y + self.animationRootView.frame.height
                if index.isEven{
                    let line = UIImageView()
                    line.image = self.TreeLineToRight.image
                    line.contentMode = self.TreeLineToLeft.contentMode
                    line.backgroundColor = self.TreeLineToLeft.backgroundColor
                    line.frame.size = self.TreeLineToLeft.frame.size
                    if beforeIndex != 0{
                        line.frame.size.width = line.frame.size.width/2
                    }
                    
                    line.frame.origin = (self.TreeBox[beforeIndex]?.frame.origin)!
                    line.frame.origin.x = line.frame.origin.x + (self.TreeBox[beforeIndex]?.frame.width)! + self.animationRootView.frame.width
                    line.frame.origin.y = line.frame.origin.y + (self.TreeBox[beforeIndex]?.frame.height)!
                    self.animationRootView.addSubview(line)
                    self.animationRootView.bringSubview(toFront: line)
                    //                put it in right
                    
                    let box = UIView()
                    box.backgroundColor = self.originalColor
                    box.frame.size = self.TreeBoxSize
                    box.frame.origin = line.frame.origin
                    box.frame.origin.x = box.frame.origin.x + line.frame.width
                    box.frame.origin.y = box.frame.origin.y + line.frame.height
                    let label = UILabel()
                    label.text = String(insertingNumber)
                    label.textColor = UIColor.black
                    label.frame.size = self.LinkedFontSize
                    self.animationRootView.addSubview(box)
                    box.addSubview(label)
                    label.center = box.convert(box.center, from:box.superview)
                    UIView.animate(withDuration: 1.0, animations: {
                        let boxLocation = box.frame.origin.x - self.animationRootView.frame.width + box.frame.width
                        if boxLocation < self.animationRootView.frame.width{
                            box.frame.origin.x = box.frame.origin.x - self.animationRootView.frame.width
                            line.frame.origin.x = line.frame.origin.x - self.animationRootView.frame.width
                            self.TreeBox[index] = box
                            self.TreeBoxText[index] = label
                            self.TreeLines[index] = line
                        }
                        else{
                            self.animationRootView.willRemoveSubview(box)
                            self.animationRootView.willRemoveSubview(line)
                            
                        }
                        
                        
                    }){(true) in
                        for box in self.TreeBox{
                            box.value.backgroundColor = self.originalColor
                        }
                    }
                    
                    
                    
                }
                else{
                    let line = UIImageView()
                    line.image = self.TreeLineToLeft.image
                    line.contentMode = self.TreeLineToLeft.contentMode
                    line.backgroundColor = self.TreeLineToLeft.backgroundColor
                    line.frame.size = self.TreeLineToLeft.frame.size
                    if beforeIndex != 0 {
                        line.frame.size.width = line.frame.size.width/2
                    }
                    line.frame.origin = (self.TreeBox[beforeIndex]?.frame.origin)!
                    line.frame.origin.x = line.frame.origin.x - line.frame.width + self.animationRootView.frame.width
                    line.frame.origin.y = line.frame.origin.y + (self.TreeBox[beforeIndex]?.frame.height)!
                    self.animationRootView.addSubview(line)
                    self.animationRootView.bringSubview(toFront: line)
                    
                    //            put it in left
                    let box = UIView()
                    box.backgroundColor = self.originalColor
                    box.frame.size = self.TreeBoxSize
                    box.frame.origin = line.frame.origin
                    box.frame.origin.x = box.frame.origin.x - box.frame.size.width
                    box.frame.origin.y = box.frame.origin.y + line.frame.height
                    let label = UILabel()
                    label.text = String(insertingNumber)
                    label.textColor = UIColor.black
                    label.frame.size = self.LinkedFontSize
                    self.animationRootView.addSubview(box)
                    box.addSubview(label)
                    label.center = box.convert(box.center, from:box.superview)
                    UIView.animate(withDuration: 1.0, animations: {
                        let boxLocation = box.frame.origin.x - self.animationRootView.frame.width
                        
                        if boxLocation > 0.0{
                            box.frame.origin.x = box.frame.origin.x - self.animationRootView.frame.width
                            line.frame.origin.x = line.frame.origin.x - self.animationRootView.frame.width
                            self.TreeBox[index] = box
                            self.TreeBoxText[index] = label
                            self.TreeLines[index] = line
                        }
                        else{
                            box.isHidden = true
                            line.isHidden = true
                            box.removeFromSuperview()
                            line.removeFromSuperview()
                        }
                        
                        
                    }){(true) in
                        for box in self.TreeBox{
                            box.value.backgroundColor = self.originalColor
                        }
                    }
                }
            }
            
            
            
        }
        
        
    }
    
    
    
    func TreeSearching(){
        var index = 0
        var delay = 0.0
//        var found = false
        let searchingNumber = Int(CustomizeTextField.text!)!
        while TreeHasText(node: index) == true{
            delay += 0.8
            if Int((TreeBoxText[index]?.text)!) == searchingNumber
            {
                UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                    self.TreeBox[index]?.backgroundColor = UIColor.purple
                }) { (true) in
                    let alert = UIAlertController(title: "Found!!", message: "\(self.LinkedCurrentSearchingNumber) is located at \(index) of this tree", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: { action in
                        for box in self.TreeBox{
                            box.value.backgroundColor = self.originalColor
                        }
                    }))
                    self.present(alert, animated: true)
//                    found = true
                    
                }
                break
            }
            else if Int((TreeBoxText[index]?.text)!)! > searchingNumber{
                //going left
                UIView.animate(withDuration: 1.0, delay: delay+0.2, options: [.beginFromCurrentState], animations: {
                    self.TreeBox[index]?.backgroundColor = UIColor.gray
                    index = self.TreeGetLeftChild(node: index)
                }) { (true) in
                    if self.TreeHasText(node: index) == false{
                        let alert = UIAlertController(title: "NOT Found!!", message: "\(self.LinkedCurrentSearchingNumber) is  not located at this tree", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: { action in
                            for box in self.TreeBox{
                                box.value.backgroundColor = self.originalColor
                            }
                        }))
                        self.present(alert, animated: true)
                    }
                }
            }
            else if Int((TreeBoxText[index]?.text)!)! < searchingNumber{
                //going right
                UIView.animate(withDuration: 1.0, delay: delay+0.2, options: [.beginFromCurrentState], animations: {
                    self.TreeBox[index]?.backgroundColor = UIColor.gray
                    index = self.TreeGetRightChild(node: index)
                    
                }) { (true) in
                    if self.TreeHasText(node: index) == false{
                        let alert = UIAlertController(title: "NOT Found!!", message: "\(self.LinkedCurrentSearchingNumber) is  not located at this tree", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: { action in
                            for box in self.TreeBox{
                                box.value.backgroundColor = self.originalColor
                            }
                        }))
                        self.present(alert, animated: true)
                    }
                }
            }
        }
    }
    
}
