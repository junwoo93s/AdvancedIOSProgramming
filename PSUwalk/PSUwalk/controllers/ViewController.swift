//
//  ViewController.swift
//  PSUwalk
//
//  Created by Junwoo Seo on 10/13/18.
//  Copyright © 2018 Junwoo Seo. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController {

    let mapModel = MapModel.sharedInstance
    let spanDelta = 0.01
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let location = mapModel.initialLocation
        let coordinate = location.coordinate
        let span = MKCoordinateSpan(latitudeDelta: spanDelta, longitudeDelta: spanDelta)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

