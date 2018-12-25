//
//  SearchViewController.swift
//  AlgorithmStudy
//
//  Created by Junwoo Seo on 11/30/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import UIKit

extension InfoViewController {

    
    @objc func SearchingFunction(){
        
        if CustomizeTextField.isHidden == true{
            for box in self.SearchBoxOrders{
                box.backgroundColor = originalColor
            }
            LinkedCustomTextFieldShowing()
        }
        else{
            LinkedCustomTextFieldHiding()
            if CustomizeTextField.text != ""{
                WhichSearching()
            }
            
        }
        
    }
    
    func WhichSearching(){
        if currentAlgorithmName.contains("Breadth First Search"){
            BFSfunction()
            
        }
        else{
            DFSfunction()
        }
    }
    
    func backToOriginal(){
        var delay = 0.0
        UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
            for box in self.SearchBoxOrders{
                delay += 0.5
                box.backgroundColor = UIColor.blue
            }
        }) { (true) in
            
        }
    }
    
    func BFSfunction(){
        let seletedNumber = Int(CustomizeTextField.text!)!
        var currentPoint = SearchSteps[seletedNumber]
        self.SearchBoxOrders[seletedNumber-1].backgroundColor = UIColor.gray
        var delay = 0.0
        var cantGoFurther = false
        while cantGoFurther == false{
            delay += 0.8
            for index in currentPoint!{
                UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                    if self.SearchBoxOrders[index-1].backgroundColor != UIColor.gray{
                        self.SearchBoxOrders[index-1].backgroundColor = UIColor.gray
                    }
                }, completion: { (true) in
                    
                })
            }
            var tempArray = [0]
            var count = 0
            for index in currentPoint!{
                for variable in (self.SearchSteps[index]!){
                    if tempArray.contains(variable) == false{
                        tempArray.append(variable)
                    }
                }
            }
            currentPoint = tempArray
            for check in 0 ... (currentPoint?.count)! - 1{
                if currentPoint![check] == 0{
                    currentPoint?.remove(at: check)
                    break
                }
            }
            
            for x in currentPoint!{
                if self.SearchBoxOrders[x-1].backgroundColor == UIColor.gray{
                    count += 1
                }
            }
            if count == currentPoint!.count{
                cantGoFurther = true
            }
        }
    }
    
    func DFSfunction(){
        let seletedNumber = Int(CustomizeTextField.text!)!
        var currentPoint = SearchSteps[seletedNumber]
        self.SearchBoxOrders[seletedNumber-1].backgroundColor = UIColor.gray
        var delay = 0.0
        while currentPoint?.isEmpty == false{
            delay += 0.8
            UIView.animate(withDuration: 1.0, delay: delay, options: [.beginFromCurrentState], animations: {
                if self.SearchBoxOrders[currentPoint![0]-1].backgroundColor != UIColor.gray{
                    self.SearchBoxOrders[currentPoint![0]-1].backgroundColor = UIColor.gray
                    
                    if currentPoint?.count == 1{
                        let temp = currentPoint![0]
                        currentPoint = self.SearchSteps[currentPoint![0]]! + [temp]
                        
                    }
                    else{
                        currentPoint = self.SearchSteps[currentPoint![0]]! + currentPoint![1...(currentPoint?.count)!-1]

                    }
                }
                else{
                    currentPoint?.remove(at: 0)
                }
            }) { (true) in
                
            }
            
        }
    }
    
    
}
