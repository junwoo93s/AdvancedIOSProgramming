//
//  LinkedViewController.swift
//  AlgorithmStudy
//
//  Created by Junwoo Seo on 11/30/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import UIKit

extension InfoViewController{
    
    func LinkedDeleting(){
        var delay = 0.0
        var counter = 0
        var found = false
        let deletingNumber = Int(CustomizeTextField.text!)!
        searchingloop : for label in LinkedListBoxText{
            delay += 0.7
            
            if deletingNumber == Int(label.text!)!{
                UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                    self.LinkedListBox[counter].backgroundColor = UIColor.purple
                }) { (true) in
                    UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                        self.LinkedListBox[counter].frame.origin.x = self.animationRootView.frame.width * 1.1
                        if counter != 0{
                            self.LinkedListArrowBox[counter-1].frame.origin.x = self.animationRootView.frame.width * 1.1
                            
                        }
                        else{
                            if self.LinkedListArrowBox.count != 0{
                                
                                self.LinkedListArrowBox[counter].frame.origin.x = self.animationRootView.frame.width * 1.1
                                
                            }
                        }
                        
                    }, completion: { (true) in
                        
                        let length = self.LinkedListBox.count
                        if counter < length {
                            UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                                for i in counter..<length-1{
                                    self.LinkedListBox[i+1].frame.origin.x = self.LinkedListBox[i+1].frame.origin.x + self.LinkedBoxDistance
                                }
                                if self.LinkedListArrowBox.count != 1{
                                    for i in counter-1..<length-2{
                                        self.LinkedListArrowBox[i+1].frame.origin.x = self.LinkedListArrowBox[i+1].frame.origin.x + self.LinkedBoxDistance
                                    }
                                }
                                
                            }, completion: { (true) in
                                self.LinkedListBox[counter].removeFromSuperview()
                                if counter != 0{
                                    self.LinkedListArrowBox[counter-1].removeFromSuperview()
                                    self.LinkedListArrowBox.remove(at: counter-1)
                                }
                                else{
                                    if self.LinkedListArrowBox.count != 0 {
                                        self.LinkedListArrowBox[counter].removeFromSuperview()
                                        self.LinkedListArrowBox.remove(at: counter)
                                    }
                                    
                                }
                                self.LinkedListBox.remove(at: counter)
                                self.LinkedListBoxText.remove(at: counter)
                                for box in self.LinkedListBox{
                                    box.backgroundColor = self.originalColor
                                }
                            })
                        }
                        
                        
                    })
                }
                found = true
                break searchingloop
            }
            else{
                UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                    self.LinkedListBox[counter].backgroundColor = UIColor.gray
                }) { (true) in
                    if counter + 1 >= self.LinkedListBoxText.count{
                        if found == false{
                            let alert = UIAlertController(title: "Not Found!!", message: "\(deletingNumber) is not located in this linked list", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: { action in
                                for box in self.LinkedListBox{
                                    box.backgroundColor = self.originalColor
                                }
                            }))
                            self.present(alert, animated: true)
                        }
                    }
                }
            }
            counter += 1
            
        }
    }
    func LinkedInserting(){
        let InsertingNumber = Int(CustomizeTextField.text!)!
        if LinkedListBox.isEmpty == false && LinkedListArrowBox.isEmpty == false{
            
            let distance = (LinkedListBox.last?.frame.origin.x)! - ((LinkedListArrowBox.last?.frame.origin.x)! + (LinkedListArrowBox.last?.frame.width)!)
            let arrowImage = UIImageView()
            if currentAlgorithmName.contains("Doubly"){
                arrowImage.image = #imageLiteral(resourceName: "doubleArrow")
            }
            else{
                arrowImage.image = #imageLiteral(resourceName: "arrow")
                
            }
            
            arrowImage.contentMode = .scaleAspectFit
            arrowImage.frame.origin = CGPoint(x: animationRootView.frame.width * 1.1, y: LinkedArrowPoint.y)
            let sizeOfArrow = LinkedArrowSize
            arrowImage.frame.size = sizeOfArrow
            
            let box = UIView()
            box.frame.size = LinkedBoxSize
            box.frame.origin = CGPoint(x: animationRootView.frame.width * 1.1, y: LinkedBoxPoint.y)
            
            box.backgroundColor = originalColor
            
            let label = UILabel()
            label.text = String(InsertingNumber)
            label.textColor = UIColor.black
            label.frame.size = LinkedFontSize
            
            animationRootView.addSubview(arrowImage)
            animationRootView.addSubview(box)
            box.addSubview(label)
            label.center = box.convert(box.center, from:box.superview)
            
            
            UIView.animate(withDuration: 1.0) {
                arrowImage.frame.origin.x = CGFloat(((self.LinkedListBox.last?.frame.origin.x)! + (self.LinkedListBox.last?.frame.width)!) + distance)
                box.frame.origin.x = CGFloat(arrowImage.frame.origin.x + arrowImage.frame.width) + CGFloat(distance)
            }
            LinkedListArrowBox.append(arrowImage)
            LinkedListBox.append(box)
            LinkedListBoxText.append(label)
        }
        else if LinkedListBox.isEmpty == true{
            let box = UIView()
            box.frame.size = LinkedBoxSize
            box.frame.origin = LinkedBoxPoint
            box.frame.origin.x = box.frame.origin.x + animationRootView.frame.width
            box.backgroundColor = originalColor
            let label = UILabel()
            label.text = String(InsertingNumber)
            label.textColor = UIColor.black
            label.frame.size = LinkedFontSize
            box.addSubview(label)
            LinkedListBox.append(box)
            LinkedListBoxText.append(label)
            animationRootView.addSubview(box)
            label.center = box.convert(box.center, from:box.superview)
            UIView.animate(withDuration: 1.0) {
                box.frame.origin.x = box.frame.origin.x - self.animationRootView.frame.width
            }
            
            
        }
        else if LinkedListBox.isEmpty == false && LinkedListArrowBox.isEmpty == true{
            let arrowImage = UIImageView(image: #imageLiteral(resourceName: "arrow"))
            let box = UIView()
            box.frame.size = LinkedBoxSize
            box.frame.origin = LinkedBoxPoint
            box.frame.origin.x = box.frame.origin.x - LinkedBoxDistance + animationRootView.frame.width
            box.backgroundColor = originalColor
            let label = UILabel()
            label.text = String(LinkedCurrentSearchingNumber)
            label.textColor = UIColor.black
            label.frame.size = LinkedFontSize
            box.addSubview(label)
            
            
            arrowImage.contentMode = .scaleAspectFill
            arrowImage.frame.origin = LinkedArrowPoint
            arrowImage.frame.origin.x = arrowImage.frame.origin.x + animationRootView.frame.width
            let sizeOfArrow = LinkedArrowSize
            arrowImage.frame.size = sizeOfArrow
            LinkedListBox.append(box)
            LinkedListBoxText.append(label)
            animationRootView.addSubview(box)
            label.center = box.convert(box.center, from:box.superview)
            
            LinkedListArrowBox.append(arrowImage)
            animationRootView.addSubview(arrowImage)
            UIView.animate(withDuration: 1.0) {
                box.frame.origin.x = box.frame.origin.x - self.animationRootView.frame.width
                arrowImage.frame.origin.x = arrowImage.frame.origin.x - self.animationRootView.frame.width
            }
        }
        
    }
    
    
    func LinkedSearching(){
        var delay = 0.0
        var counter = 0
        var found = false
        let searchingNumber = Int(CustomizeTextField.text!)!
        searchingloop : for label in LinkedListBoxText{
            delay += 0.7
            
            if searchingNumber == Int(label.text!)!{
                UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                    self.LinkedListBox[counter].backgroundColor = UIColor.purple
                }) { (true) in
                    let alert = UIAlertController(title: "Found!!", message: "\(searchingNumber) is located at \(counter+1) of this linked list", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: { action in
                        for box in self.LinkedListBox{
                            box.backgroundColor = self.originalColor
                        }
                    }))
                    self.present(alert, animated: true)
                }
                found = true
                break searchingloop
            }
            else{
                UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                    self.LinkedListBox[counter].backgroundColor = UIColor.gray
                }) { (true) in
                    if counter + 1 >= self.LinkedListBoxText.count{
                        if found == false{
                            let alert = UIAlertController(title: "Not Found!!", message: "\(searchingNumber) is not located in this linked list", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: { action in
                                for box in self.LinkedListBox{
                                    box.backgroundColor = self.originalColor
                                }
                            }))
                            self.present(alert, animated: true)
                        }
                    }
                }
            }
            counter += 1
            
        }
        
    }
    
}
