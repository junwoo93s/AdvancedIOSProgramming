//
//  ScrollModel.swift
//  scroll
//
//  Created by Junwoo Seo on 9/22/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import Foundation


struct ParkLabel : Codable {
    var name : String
    var photos : [ParkImage]
}

struct ParkImage : Codable {
    var imageName : String
    var caption : String
}

//The model should read in the property list containing all the park and photo information.
//Give the model a clean, simple interface that provides park and photo information.
//You’ll be reusing this model in subsequent weeks, so give it a clean, flexible interface.

typealias parkLabel = [ParkLabel]
typealias parkImage = [ParkImage]

typealias labelElements = parkLabel
typealias imageElements = parkImage

class Model {
    
    let allParkList : labelElements
    
    
    init () {
        let mainBundle = Bundle.main
        let parklistURL = mainBundle.url(forResource: "StateParks", withExtension: "plist")
        
        do {
            let data = try Data(contentsOf: parklistURL!)
            let decoder = PropertyListDecoder()
            allParkList = try decoder.decode(labelElements.self, from: data)
        } catch {
            print(error)
            allParkList = []
        }
        
    }

    func parkLabelCall(i : Int) -> String{
        return allParkList[i].name
    }
    func imageNameCall(i : Int, j: Int) -> String {
        let imageName = allParkList[i].photos[j].imageName + ".png"
        return imageName
    }
    func captionCall(i: Int, j: Int) -> String {
        let captionString = allParkList[i].photos[j].caption
        return captionString
    }
    func parkTotalCount()-> Int {
        return allParkList.count
    }
    func imageTotalCount(i: Int) -> Int {
        return allParkList[i].photos.count
    }
}
