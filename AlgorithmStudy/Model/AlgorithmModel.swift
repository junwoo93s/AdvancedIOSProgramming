//
//  MapModel.swift
//  PSUwalk
//
//  Created by Junwoo Seo on 10/13/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import Foundation

struct AlgorithmName : Codable {
    var name: String
    var timeComplex : [[String]]
    var spaceComplex : [String]
    var realLife : String
    var type : String
    var animation : String?
    var sampleCode : String?
}

typealias algorithmname = [AlgorithmName]

typealias algorithmList = [String:algorithmname]


class AlgorithmModel {
//    var allAlgorithm : algorithmname
    
    let Algorithms : algorithmList
    
//    static let sharedInstance = MapModel()
    init() {
        let mainBundle = Bundle.main
        let buildingURL = mainBundle.url(forResource: "algorithm", withExtension: "plist")
        do{
            let data = try Data(contentsOf: buildingURL!)
            let decoder = PropertyListDecoder()
            Algorithms = try decoder.decode(algorithmList.self, from: data)
//            Building.sort { (left: BuildingName, right: BuildingName) -> Bool in
//                return left.name < right.name
//
//            }
            
        }catch{
            print(error)
            Algorithms = [:]
        }
    }
    
    
    var AllSectionTitleInArray = {return ["Sorting", "Linked List", "Tree", "Hash Table", "Searching"]}
    
    func RowNumberSectionTitle(index : Int) -> Int{
        let sectionTitle = AllSectionTitleInArray()[index]
        let returnValue = Algorithms[sectionTitle]?.count
        
        return returnValue!
    }
    func infoForEachRow(section : Int, row : Int) -> AlgorithmName{
        let sectionTitle = AllSectionTitleInArray()[section]
        let specificCategory = Algorithms[sectionTitle]![row]
        return specificCategory
    }
    
    func titleForEachRow(section : Int, row : Int) -> String{
        return infoForEachRow(section: section, row: row).name
    }
    
    func timeComplexForEachRow(section : Int, row : Int) -> [[String]]{
        return infoForEachRow(section: section, row: row).timeComplex
    }
    func spaceComplexForEachRow(section : Int, row : Int) -> [String]{
        return infoForEachRow(section: section, row: row).spaceComplex
    }
    func realLifeForEachRow(section : Int, row : Int) -> String{
        return infoForEachRow(section: section, row: row).realLife
    }
    func typeForEachRow(section : Int, row : Int) -> String{
        return infoForEachRow(section: section, row: row).type
    }
    func getSampleCode(section : Int, row : Int) ->String{
        return infoForEachRow(section: section, row: row).sampleCode!
        
    }
}
