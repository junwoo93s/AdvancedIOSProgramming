//
//  QuizModel.swift
//  AlgorithmStudy
//
//  Created by Junwoo Seo on 12/4/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import Foundation


struct QuizName : Codable {
    var type1 : [String]
}

typealias quizname = [QuizName]

typealias quizList = [String:quizname]


class QuizModel {
    //    var allAlgorithm : algorithmname
    
    let Quizs : quizList
    
    //    static let sharedInstance = MapModel()
    init() {
        let mainBundle = Bundle.main
        let buildingURL = mainBundle.url(forResource: "QuizList", withExtension: "plist")
        do{
            let data = try Data(contentsOf: buildingURL!)
            let decoder = PropertyListDecoder()
            Quizs = try decoder.decode(quizList.self, from: data)
            //            Building.sort { (left: BuildingName, right: BuildingName) -> Bool in
            //                return left.name < right.name
            //
            //            }
        }catch{
            print(error)
            Quizs = [:]
        }
    }
    
    
    var AllSectionTitleInArray = {return ["Sorting", "Linked List", "Tree", "Hash Table", "Searching"]}
    
    func infoForEachRow(section : Int) -> QuizName{
        let sectionTitle = AllSectionTitleInArray()[section]
        let specificCategory = Quizs[sectionTitle]!
        return specificCategory[0]
    }
}
