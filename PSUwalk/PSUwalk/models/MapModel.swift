//
//  MapModel.swift
//  PSUwalk
//
//  Created by Junwoo Seo on 10/13/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import Foundation
import MapKit

struct BuildingName : Codable {
    var name: String
    var opp_bldg_code : Int
    var year_constructed : Int
    var latitude : Double
    var longitude : Double
    var photo : String?
    var searchKey : String {return name + " " + String(year_constructed)}
    
}

typealias buildingname = [BuildingName]

typealias buildinglist = buildingname


class Place : NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title : String?

    
    init(title:String?, coordinate:CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}

class MapModel {
    var allBuilding : buildingname

    var Building : buildinglist
    
    static let sharedInstance = MapModel()
    fileprivate init() {
        let mainBundle = Bundle.main
        let buildingURL = mainBundle.url(forResource: "buildings", withExtension: "plist")
        do{
            let data = try Data(contentsOf: buildingURL!)
            let decoder = PropertyListDecoder()
            Building = try decoder.decode(buildinglist.self, from: data)
            Building.sort { (left: BuildingName, right: BuildingName) -> Bool in
                return left.name < right.name
                
            }
            
        }catch{
            print(error)
            Building = []
        }
        allBuilding = Building
    }
    
    
    
    //MARK: - Locations
    // Centered in downtown State College
    let initialLocation = CLLocation(latitude: 40.800845, longitude: -77.861880)
    
    // define 4 corner points of downtown State College
    let downtownCoordinates = [(40.796755, -77.872398),
                               (40.810108, -77.861974),
                               (40.802429, -77.850881),
                               (40.791790, -77.865249)].map {(a,b) in CLLocationCoordinate2D(latitude: a, longitude: b)}
    

    
    
    //MARK: - Search Categories
    fileprivate let categories = ["Airport", "Bar", "Coffee", "Dining", "Gas Station", "Grocery", "Hospital", "Hotel", "Laundry", "Library", "Movies", "Parking", "Pizza", "Shopping"]
    
    var categoryCount : Int {return categories.count}
    
    func category(atIndex index:Int) -> String? {
        guard categories.indices.contains(index) else {return nil}
        return categories[index]
    }
    
    func imageNameFor(category:String) -> String {
        return category
    }
    
    var buildingCount : Int {return Building.count}
    
    func buildingInfoWithIndex(index : Int)->BuildingName{
        return Building[index]
    }
    func buildingNameIndex(index : Int)->String{
        return Building[index].name
    }
    
    func buildingLatIndex(index : Int) ->Double{
        return Building[index].latitude
    }
    func buildingLongIndex(index : Int) ->Double{
        return Building[index].longitude
    }
    
    func buildingYearIndex(index : Int)->Int{
        return Building[index].year_constructed
    }
    
    func buildingOPPCode(index : Int)->Int{
        return Building[index].opp_bldg_code
    }
    
    func AllBuildingNames()->[String]{
        var Listbuilding = [String]()
        for i in 0..<Building.count{
            Listbuilding.append(Building[i].name)
        }
        return Listbuilding
    }
    
    func AlphabetName()->[String]{
        var arrayofCharaters = [String]()
        var before = ""
        let ListBuilding = arrayOfName()
        for j in ListBuilding{
            let current = (j.prefix(1)).uppercased()
            if current != before{
                before = current
                arrayofCharaters.append(current)
            }
            
        }
        return arrayofCharaters
        
    }
    
    func arrayOfName()->[String]{
        var Listbuilding = [String]()
        for i in 0..<Building.count{
            Listbuilding.append(Building[i].name)
        }
        return Listbuilding
    }
    
    func eachRowsInSection(index:Int)->[String]{
        let arrayOfCharaters = AlphabetName()
        let currentAlpha = arrayOfCharaters[index]
        let ListBuilding = arrayOfName()
        var returnArr = [String]()
        for j in ListBuilding{
            let current = j.prefix(1).uppercased()
//                (String(j.characters.prefix(1))).uppercased()
            if current == currentAlpha{
                returnArr.append(j)
            }
        }
        return returnArr
    }
    
    func eachRowsLatInSection(index: Int)->[Double]{
        let arrayOfCharaters = AlphabetName()
        var latitude = [Double]()
        let currentAlpha = arrayOfCharaters[index]
        for i in 0..<Building.count{
            let current = Building[i].name.prefix(1).uppercased()
            if current == currentAlpha{
                latitude.append(Building[i].latitude)
            }
        }
        return latitude
    }
    func eachRowsLongInSection(index: Int)->[Double]{
        let arrayOfCharaters = AlphabetName()
        var long = [Double]()
        let currentAlpha = arrayOfCharaters[index]
        for i in 0..<Building.count{
            let current = Building[i].name.prefix(1).uppercased()
            if current == currentAlpha{
                long.append(Building[i].longitude)
            }
        }
        return long
    }
    
    func getRowDetail(section: Int, row: Int)->Int{
        var counter = 0
        var sum = 0
        while counter != section{
            let eachRowsInSectionNumber = eachRowsLongInSection(index: counter).count
            sum = sum + eachRowsInSectionNumber
            counter = counter + 1

        }
        sum = sum + row
        
        
        return sum
    }
    
    func getSectionAndRowNumber(index: Int)->[Int]{
        var sectionAndRow = [Int]()
        let name = Building[index].name
        var section = 0
        var row = 0
        while section <= Building.count{
            let eachName = eachRowsInSection(index: section)
            for specificName in eachName{
                if specificName == name{
                    return [section,row]
                }
                row = row + 1
            }
            section = section + 1
            row = 0
        }
        sectionAndRow.append(section)
        sectionAndRow.append(row)
        return sectionAndRow
    }
    
    func withBuildingNameGetSectionAndRowNumber(name: String)->[Int]{
        let allSection = AlphabetName()
        let currentSection = name.prefix(1).uppercased()
        var section = 0
        for i in 0..<allSection.count{
            if allSection[i] == currentSection{
                section = i
                break
            }
        }
        let allNameInSection = eachRowsInSection(index: section)
        var row = 0
        for j in 0..<allNameInSection.count{
            if allNameInSection[j] == name{
                row = j
                break
            }
        }
        return [section,row]
        
        
    }
    
    func FindInfoWithName(name: String)->BuildingName{
        let returnValue = BuildingName(name: "temp", opp_bldg_code: 0, year_constructed: 0, latitude: 0, longitude: 0, photo: "0")
        for eachBuilding in Building{
            if eachBuilding.name == name{
                return eachBuilding
            }
        }
        return returnValue
    }
    
    func updateFilter(filter: (BuildingName) -> Bool) {
        Building = allBuilding.filter(filter)
        
    }
    
    func FindIndexInfoWithName(name: String)->Int{
        var count = 0
        for eachBuilding in allBuilding{
            if eachBuilding.name == name{
                return count
            }
            
            count = count+1
            
        }
        return 0
    }
    
    
    
}
