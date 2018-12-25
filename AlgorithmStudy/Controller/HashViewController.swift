//
//  HashViewController.swift
//  AlgorithmStudy
//
//  Created by Junwoo Seo on 11/29/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import UIKit

extension InfoViewController {
    
    func HashDeleting(){
        let deletingNumber = Int(CustomizeTextField.text!)!
        let targetHash = deletingNumber % HashRootBox.count
        var delay = 0.0
        for index in 0..<HashRootBox.count{
            delay += 0.5
            
            if targetHash == index{
                UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                    self.HashRootBox[index]?.first?.backgroundColor = UIColor.orange
                    
                }) { (true) in
                    var insideIndex = 1
                    while deletingNumber != Int(self.HashRootBoxText[index]![insideIndex].text!)!{
                        UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                         
                            self.HashRootBox[index]![insideIndex].backgroundColor = UIColor.gray

                            
                            
                        }, completion: { (true) in
                        })
                        insideIndex += 1
                    }
                    
                    delay += 1.0
                    if self.HashRootBoxText[index]![insideIndex].text == String(deletingNumber){
                        if self.HashRootBoxText[index]!.count - 1 == insideIndex{
                            UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                                self.HashRootBox[index]![insideIndex].frame.origin.x = self.HashRootBox[index]![insideIndex].frame.origin.x + self.animationRootView.frame.width * 1.1
                                self.HashRootArrowBox[index]![insideIndex].frame.origin.x = self.HashRootArrowBox[index]![insideIndex].frame.origin.x + self.animationRootView.frame.width * 1.1
                                

                            }, completion: { (true) in
                                self.HashRootBox[index]?.remove(at: insideIndex)
                                self.HashRootArrowBox[index]?.remove(at: insideIndex)
                                self.HashRootBoxText[index]?.remove(at: insideIndex)
                                for box in self.HashRootBox{
                                    for inbox in box.value{
                                        inbox.backgroundColor = self.originalColor
                                    }
                                }
                            })
                        }
                        else{
                            UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                                self.HashRootBox[index]![insideIndex+1].frame.origin = self.HashRootBox[index]![insideIndex].frame.origin
                                self.HashRootArrowBox[index]![insideIndex+1].frame.origin = self.HashRootArrowBox[index]![insideIndex].frame.origin
                                self.HashRootBox[index]![insideIndex].frame.origin.x = self.HashRootBox[index]![insideIndex].frame.origin.x + self.animationRootView.frame.width * 1.1
                                self.HashRootArrowBox[index]![insideIndex].frame.origin.x = self.HashRootArrowBox[index]![insideIndex].frame.origin.x + self.animationRootView.frame.width * 1.1
                                
                                
                            }, completion: { (true) in
                                self.HashRootBox[index]?.remove(at: insideIndex)
                                self.HashRootArrowBox[index]?.remove(at: insideIndex)
                                self.HashRootBoxText[index]?.remove(at: insideIndex)
                                for box in self.HashRootBox{
                                    for inbox in box.value{
                                        inbox.backgroundColor = self.originalColor
                                    }
                                }
                            })
                            
                        }
                    }
                    
                }
                break
            }
            else{
                UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                    self.HashRootBox[index]?.first?.backgroundColor = UIColor.gray
                    
                }) { (true) in
                    
                }
            }
            
        }
        
        
        
    }
    
    
    func HashSearching(){
        let searchingNumber = Int(CustomizeTextField.text!)!
        let targetHash = searchingNumber % HashRootBox.count
        var delay = 0.0
        var found = false
        var foundIndex = Int()

        for index in 0..<HashRootBox.count{
            delay += 0.5
            
            if targetHash == index{
                UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                    self.HashRootBox[index]?.first?.backgroundColor = UIColor.orange
                    
                }) { (true) in
                    let length = self.HashRootBox[index]!.count
                    for insideIndex in 1 ..< length{
                        delay += 0.3
                        UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                            if searchingNumber == Int(self.HashRootBoxText[index]![insideIndex].text!)!{
                                self.HashRootBox[index]![insideIndex].backgroundColor = UIColor.orange
                                found = true
                                foundIndex = insideIndex
                                
                            }
                            else{
                                self.HashRootBox[index]![insideIndex].backgroundColor = UIColor.gray
                                
                            }
                        }, completion: { (true) in
                            if found == true{
                                let alert = UIAlertController(title: "Found!", message: "\(searchingNumber) is located at Hash Table at i = \(index) on \(foundIndex)", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: { action in
                                    for box in self.HashRootBox{
                                        for inbox in box.value{
                                            inbox.backgroundColor = self.originalColor
                                        }
                                    }
                                }))
                                self.present(alert, animated: true)
                            }
                            else{
                                let alert = UIAlertController(title: "Not Found!", message: "\(searchingNumber) is not located at Hash Table", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: { action in
                                    for box in self.HashRootBox{
                                        for inbox in box.value{
                                            inbox.backgroundColor = self.originalColor
                                        }
                                    }
                                }))
                                self.present(alert, animated: true)
                            }
                            
                        })
                        
                    }
                }
                break
            }
            else{
                UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                    self.HashRootBox[index]?.first?.backgroundColor = UIColor.gray
                    
                }) { (true) in
                }
            }
            
        }
        
        
    
    }
    
    func HashInserting(){
        let insertingNumber = Int(CustomizeTextField.text!)!
        let targetHash = insertingNumber % HashRootBox.count
        print(targetHash)
        var delay = 0.0
        for index in 0..<HashRootBox.count{
            delay += 0.5

            if targetHash == index{
                UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                    self.HashRootBox[index]?.first?.backgroundColor = UIColor.orange
                    
                }) { (true) in
                    let arrowImage = UIImageView()
                    arrowImage.image = #imageLiteral(resourceName: "ArrowDown")
                    arrowImage.contentMode = .scaleAspectFit
                    let sizeOfArrow = CGSize(width: self.LinkedArrowSize.height, height: self.LinkedArrowSize.width)
                    arrowImage.frame.size = sizeOfArrow
                    let xPoint = (self.HashRootBox[index]?.last?.center.x)! + self.animationRootView.frame.width
                    let yPoint = (self.HashRootBox[index]?.last?.frame.origin.y)! + (self.HashRootBox[index]?.last?.frame.height)! + self.LinkedArrowSize.height/2
                    arrowImage.center.x = xPoint
                    arrowImage.center.y = yPoint
                    let box = UIView()
                    box.backgroundColor = self.originalColor
                    box.frame.size = self.HashBoxSize
                    box.frame.origin =  (self.HashRootBox[index]?.last?.frame.origin)!
                    box.frame.origin.x = box.frame.origin.x + self.animationRootView.frame.width
                    box.frame.origin.y = box.frame.origin.y + self.HashBoxSize.height + self.LinkedArrowSize.width
                    let label = UILabel()
                    label.text = String(insertingNumber)
//                    label.sizeToFit()
                    label.adjustsFontSizeToFitWidth = true
                    label.textColor = UIColor.black
                    label.frame.size = self.LinkedFontSize
                    self.animationRootView.addSubview(box)
                    self.animationRootView.addSubview(arrowImage)
                    box.addSubview(label)
                    label.center = box.convert(box.center, from:box.superview)
                    UIView.animate(withDuration: 1.0, animations: {
                        let boxLocation = box.frame.origin.y + box.frame.height
                        if boxLocation < self.animationRootView.frame.height{
                            print("hello")
                            box.frame.origin.x = box.frame.origin.x - self.animationRootView.frame.width
                            arrowImage.frame.origin.x = arrowImage.frame.origin.x - self.animationRootView.frame.width
                            print(index)
                            self.HashRootBox[index]?.append(box)
                            self.HashRootBoxText[index]?.append(label)
                            self.HashRootArrowBox[index]?.append(arrowImage)
                        }
                        else{
                            let alert = UIAlertController(title: "Full!", message: "Hash Table at i = \(index) is Full", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: { action in
                                for box in self.HashRootBox{
                                    for inbox in box.value{
                                        inbox.backgroundColor = self.originalColor
                                    }
                                }
                            }))
                            self.present(alert, animated: true)
                            self.animationRootView.willRemoveSubview(box)
                            self.animationRootView.willRemoveSubview(arrowImage)
                        }
                    }){(true) in
                        for box in self.HashRootBox{
                            for inbox in box.value{
                                inbox.backgroundColor = self.originalColor
                            }
                        }
                    }
                }
                break
            }
            else{
                UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                    self.HashRootBox[index]?.first?.backgroundColor = UIColor.gray
                    
                }) { (true) in
                }
            }
            
        }
        
        
    }
}


