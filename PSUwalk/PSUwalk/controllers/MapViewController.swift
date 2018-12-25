

import UIKit
import MapKit



class DroppedPin : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title : String?
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}

class FavPin : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title : String?
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}


protocol MapDelegate {
    func checkSelected(checked: [Bool])
}



class MapViewController: UIViewController, MKMapViewDelegate, CategoryDelegate, CLLocationManagerDelegate, StepDelegate{
    
    
    
    func stepDisplay(row: Int) {
        dismiss(animated: true, completion: nil)

        self.mapView.setCenter(stepCoordinateArray[row], animated: true)
    }
    
    func checkHeart(heart: UIImage, row: Int) {
        if heart == #imageLiteral(resourceName: "Heart"){
            isChecked[row] = false
            let infoValue = mapModel.Building[row]
            for pins in mapView.annotations{
                if pins.title == infoValue.name{
                    mapView.removeAnnotation(pins)
                    let sectionAndRow = mapModel.getSectionAndRowNumber(index: row)
                    var countFavorite = 0
                    if onlyFavoritePin.count > 0 {
                        for pins in self.onlyFavoritePin{
                            if pins.title == infoValue.name{
                                self.onlyFavoritePin.remove(at: countFavorite)
                                
                            }
                            else{
                                countFavorite = countFavorite + 1
                            }
                        }
                    }

                    displayCategory(section: sectionAndRow[0], row: sectionAndRow[1])
                    
                }
            }
        }
        else{
            isChecked[row] = true
            let infoValue = mapModel.allBuilding[row]
            for pins in mapView.annotations{
                if pins.title == infoValue.name{
                    mapView.removeAnnotation(pins)
                    let sectionAndRow = mapModel.getSectionAndRowNumber(index: row)
                    var countNotFavorite = 0
                    if onlyNotFavoritePin.count > 0{
                        for pins in self.onlyNotFavoritePin{
                            if pins.title == infoValue.name{
                                self.onlyNotFavoritePin.remove(at: countNotFavorite)
                            }
                            else{
                                countNotFavorite = countNotFavorite + 1
                            }
                        }
                    }

                    displayCategory(section: sectionAndRow[0], row: sectionAndRow[1])
                }
            }
        }
    }
    

    func addHiddenPins(){
        for pins in onlyFavoritePin{
            mapView.addAnnotation(pins)
        }
        for pins in onlyNotFavoritePin{
            mapView.addAnnotation(pins)
        }
    }
    @IBAction func HideButtonPressed(_ sender: UIButton) {
        if sender.titleLabel?.text == "Hide"{
            for pins in mapView.annotations{
                mapView.removeAnnotation(pins)
            }
            sender.setTitle("Show", for: .normal)
        }
        else{
            addHiddenPins()
            sender.setTitle("Hide", for: .normal)

        }

    }
    @IBAction func mapChangeBar(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            break
        }
    }

    
    @IBAction func ResetDirectionPressed(_ sender: Any) {
        for currentOverlay in mapView.overlays{
            mapView.remove(currentOverlay)
        }
        containView.isHidden = true
        
    }
    
    @IBOutlet weak var DirectionSteps: UILabel!
    @IBOutlet weak var expectedTimeArriving: UILabel!
    
    @IBAction func NextButtonPressed(_ sender: Any) {
        if indexOfDirectionArray >= direction.count{
            containView.isHidden = true
            indexOfDirectionArray = 1
            direction = [String]()
        }
        else{
            self.zoomMap()

            self.mapView.setCenter(stepCoordinateArray[indexOfDirectionArray], animated: true)
            DirectionSteps.text = direction[indexOfDirectionArray]
            indexOfDirectionArray = indexOfDirectionArray + 1
        }


    }
    
    @objc func currentButtonPressed(sender: UIButton){
        let alertView = UIAlertController(title: "User Location", message: nil, preferredStyle: .actionSheet)
        
        let currentLocationAction = UIAlertAction(title: "Current Location", style: .default) { (action) in
            if self.locationManager.location?.coordinate != nil{
                self.zoomMap()
                self.mapView.setCenter((self.locationManager.location?.coordinate)!, animated: true)
            }
            else{
                let alert = UIAlertController(title: "No Location", message: "Make sure you agree with currentLocation Usage", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "close", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
    
        let FromAction = UIAlertAction(title: "From", style: .default) { (action) in
            self.FromSearch.text = "User"
        }
        
        let ToAction = UIAlertAction(title: "To", style: .default) { (action) in
            self.ToSearch.text = "User"
        }
        
        alertView.addAction(currentLocationAction)
        alertView.addAction(FromAction)
        alertView.addAction(ToAction)
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertView.addAction(actionCancel)
        self.present(alertView, animated: true, completion: nil)
        
        
    }
    @IBAction func getDirectionPressed(_ sender: Any) {
        if showHideDirectionButton.title == "Hide Direction Bars"{
            DirectionButton.isHidden = true
            resetButton.isHidden = true
            FromSearch.isHidden = true
            ToSearch.isHidden = true
            fromLabel.isHidden = true
            toLabel.isHidden = true
            showHideDirectionButton.title = "Get Direction Bars"
        }
        else{
            DirectionButton.isHidden = false
            resetButton.isHidden = false
            FromSearch.isHidden = false
            ToSearch.isHidden = false
            fromLabel.isHidden = false
            toLabel.isHidden = false
            showHideDirectionButton.title = "Hide Direction Bars"
        }
        
    
    }
    
    
    @IBOutlet weak var showHideDirectionButton: UIBarButtonItem!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var FromSearch: UISearchBar!
    @IBOutlet weak var ToSearch: UISearchBar!
    
    @IBOutlet weak var DirectionButton: UIButton!
    @IBAction func DirectionButtonClicked(_ sender: Any) {
        
        let fromSearchText : String = FromSearch.text!
        let toSearchText : String = ToSearch.text!
        let allBuildingName = mapModel.AllBuildingNames()
        var fromUser = false
        var toUser = false
        if fromSearchText != "User"{

            if allBuildingName.contains(fromSearchText) == false{
                let alert = UIAlertController(title: "Type correct Name", message: "Make sure you are typing correct", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "close", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
        else{
            fromUser = true
        }
        if toSearchText != "User"{
            if allBuildingName.contains(toSearchText) == false{
                let alert = UIAlertController(title: "Type correct Name", message: "Make sure you are typing correct", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "close", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
            
        }
        else{
            toUser = true
        }
        
        
        let infoOfBuildingNameFrom = mapModel.FindInfoWithName(name: fromSearchText)
        let infoOfBuildingNameTo = mapModel.FindInfoWithName(name: toSearchText)
        if fromSearchText == "User"{
            fromUser = true
        }
        if toSearchText == "User"{
            toUser = true
        }
        requestDirections(fromUser: fromUser, toUser: toUser, infoOfBuildingNameFrom: infoOfBuildingNameFrom, infoOfBuildingNameTo: infoOfBuildingNameTo)
            

        

        
    }
    
    func requestDirections(fromUser: Bool, toUser: Bool, infoOfBuildingNameFrom: BuildingName, infoOfBuildingNameTo: BuildingName) {
        containView.isHidden = false
        for currentDirection in mapView.overlays{
            mapView.remove(currentDirection)
        }
        let walkingRouteRequest = MKDirectionsRequest()
        if fromUser == true{
            walkingRouteRequest.source = MKMapItem.forCurrentLocation()
        }
        else{

            let coordinate = CLLocationCoordinate2D(latitude: infoOfBuildingNameFrom.latitude, longitude: infoOfBuildingNameFrom.longitude)
            let placeMark = MKPlacemark(coordinate: coordinate )
            let item = MKMapItem(placemark: placeMark)
            walkingRouteRequest.source = item
        }
        if toUser == true{
            walkingRouteRequest.destination = MKMapItem.forCurrentLocation()
        }
        else{

            let coordinate = CLLocationCoordinate2D(latitude: infoOfBuildingNameTo.latitude, longitude: infoOfBuildingNameTo.longitude)
            let placeMark = MKPlacemark(coordinate: coordinate )
            let item = MKMapItem(placemark: placeMark)
            walkingRouteRequest.destination = item
        }

        walkingRouteRequest.transportType = .walking
        walkingRouteRequest.requestsAlternateRoutes = false
        
        
        let directions = MKDirections(request: walkingRouteRequest)
        
        directions.calculate { (response, error) in
            guard error == nil else {print(error?.localizedDescription as Any); return}
            
            let route = response?.routes.first!
            let time = route?.expectedTravelTime
            

            let expectedTime = NSDate(timeIntervalSinceNow: time!)
            let startIndex = expectedTime.description.index(expectedTime.description.startIndex, offsetBy: 11)
            let endIndex = expectedTime.description.index(expectedTime.description.endIndex, offsetBy: -9)
            let range = startIndex..<endIndex
            self.expectedTimeArriving.text = String("Expected Arrival Time from Now: \(expectedTime.description[range])")
            let steps = route?.steps
            for i in steps!{
                let dist = i.distance
                let stepCoordinate = i.polyline.coordinate
                var instruc = i.instructions
                if i.instructions == ""{
                    instruc = "Go Straight"
                }
                self.direction.append("\(instruc) with distance of \(dist) meters")
                self.stepCoordinateArray.append(stepCoordinate)
            }
            var span = MKCoordinateSpan(latitudeDelta: self.spanDelta, longitudeDelta: self.spanDelta)
            span.latitudeDelta = 0.005
            span.longitudeDelta = 0.005
            let region = MKCoordinateRegion(center: self.stepCoordinateArray[0], span: span)
            self.mapView.setRegion(region, animated: true)
            self.DirectionSteps.text = self.direction[0]
            self.mapView.add((route?.polyline)!)


            
        }

    }
    
    var changedHeightMap : [String:CGFloat] = [:]
    var saveTextView = [String:String]()
    var stepCoordinateArray = [CLLocationCoordinate2D]()
    var indexOfDirectionArray = 1
    let mapModel = MapModel.sharedInstance
    let spanDelta = 0.01
    let zoomDelta = 0.005
    var currentCenter = CLLocation()
    var favoritePin = [MKAnnotation]()
    var onlyFavoritePin = [MKAnnotation]()
    var onlyNotFavoritePin = [MKAnnotation]()
    let locationManager = CLLocationManager()
    var isChecked = [Bool](repeating: false, count: 323)
    var FavData = [BuildingName]()
    var direction = [String]()
    var recievedIndexPath = [IndexPath: UIImage]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentCenter = mapModel.initialLocation
        let location = currentCenter
        let coordinate = location.coordinate
        var span = MKCoordinateSpan(latitudeDelta: spanDelta, longitudeDelta: spanDelta)
        span.latitudeDelta = 0.01
        span.longitudeDelta = 0.01
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        containView.isHidden = true
        currentLocationButton.layer.cornerRadius = 0.5 * currentLocationButton.bounds.size.width
        currentLocationButton.backgroundColor = UIColor.white
        currentLocationButton.clipsToBounds = true
        currentLocationButton.addTarget(self, action: #selector(currentButtonPressed), for: .touchUpInside)
        DirectionButton.isHidden = true
        resetButton.isHidden = true
        FromSearch.isHidden = true
        ToSearch.isHidden = true
        fromLabel.isHidden = true
        toLabel.isHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if CLLocationManager.locationServicesEnabled() {
            let status = CLLocationManager.authorizationStatus()
            switch status {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedAlways, .authorizedWhenInUse:
                mapView.showsUserLocation = true
            default:
                break
                
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied, .restricted:
            mapView.showsUserLocation = false
        case .authorizedAlways, .authorizedWhenInUse:
            mapView.showsUserLocation = true
        default:
            break
            
        }
    }
    

    
    //MARK: - MapView Delegate
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        switch annotation {
        case is FavPin:
            return annotationView(forPin: annotation as! FavPin)
        case is DroppedPin:
            return annotationView(forPin: annotation as! DroppedPin)
        default:
            return nil
        }
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        switch overlay {
        case is MKPolygon:
            let polygon = MKPolygonRenderer(polygon: overlay as! MKPolygon)
            polygon.fillColor = UIColor.lightGray
            polygon.strokeColor = UIColor.blue
            polygon.alpha = 0.4
            polygon.lineWidth = 2.0
            return polygon
        case is MKPolyline:
            let line = MKPolylineRenderer(polyline: overlay as! MKPolyline)
            line.strokeColor = UIColor.blue
            line.lineWidth = 4.0
            return line
        default:
            assert(false, "unhandled overlay")
        }
    }
    
    
    

    
    
    
    func annotationView(forPin droppedPin:DroppedPin) -> MKAnnotationView {
        let identifier = "DroppedPin"
        var view: MKPinAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            view = dequeuedView
        } else {
            view = MKPinAnnotationView(annotation: droppedPin, reuseIdentifier: identifier)
            view.pinTintColor = MKPinAnnotationView.purplePinColor()
            view.animatesDrop = true
            view.isDraggable = true
            view.canShowCallout = true
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

        }
        return view
    }
    
    
    
    func annotationView(forPin droppedPin:FavPin) -> MKAnnotationView {
        let identifier = "FavPin"
        var view: MKPinAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            view = dequeuedView
        } else {
            view = MKPinAnnotationView(annotation: droppedPin, reuseIdentifier: identifier)
            view.pinTintColor = MKPinAnnotationView.redPinColor()
            view.animatesDrop = true
            view.isDraggable = true
            view.canShowCallout = true
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
        }
        return view
    }
    
    func deleteDroppedPin(selectedPin: DroppedPin){
        var countNotFavorite = 0
        for pins in self.onlyNotFavoritePin{
            if pins.title == selectedPin.title{
                self.onlyNotFavoritePin.remove(at: countNotFavorite)
            }
            else{
                countNotFavorite = countNotFavorite + 1
            }
        }
        self.mapView.removeAnnotation(selectedPin)
    }
    
    func deleteFavPin(selectedPin: FavPin){
        var countNotFavorite = 0
        for pins in self.onlyFavoritePin{
            if pins.title == selectedPin.title{
                self.onlyFavoritePin.remove(at: countNotFavorite)
            }
            else{
                countNotFavorite = countNotFavorite + 1
            }
        }
        self.mapView.removeAnnotation(selectedPin)
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        switch view.annotation {
        case is DroppedPin:
            let dropPin = view.annotation as! DroppedPin
            let alertView = UIAlertController(title: dropPin.title, message: nil, preferredStyle: .actionSheet)
            
            let actionDirection = UIAlertAction(title: "Directions", style: .default) { (action) in
                let infoFrom = self.mapModel.FindInfoWithName(name: dropPin.title!)
                self.requestDirections(fromUser: true, toUser: false, infoOfBuildingNameFrom: infoFrom, infoOfBuildingNameTo: infoFrom)
            }
            let deleteAction = UIAlertAction(title: "Delete", style: .default) { (action) in
                self.deleteDroppedPin(selectedPin: dropPin)
            }
            
            let FromAction = UIAlertAction(title: "From", style: .default) { (action) in
                self.FromSearch.text = dropPin.title
            }
            
            let ToAction = UIAlertAction(title: "To", style: .default) { (action) in
                self.ToSearch.text = dropPin.title
            }
            
            alertView.addAction(actionDirection)
            alertView.addAction(deleteAction)
            alertView.addAction(FromAction)
            alertView.addAction(ToAction)
            
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertView.addAction(actionCancel)
            self.present(alertView, animated: true, completion: nil)
        case is FavPin:
            let dropPin = view.annotation as! FavPin
            let alertView = UIAlertController(title: dropPin.title, message: nil, preferredStyle: .actionSheet)
            
            let actionDirection = UIAlertAction(title: "Directions", style: .default) { (action) in
                let infoFrom = self.mapModel.FindInfoWithName(name: dropPin.title!)
                self.requestDirections(fromUser: true, toUser: false, infoOfBuildingNameFrom: infoFrom, infoOfBuildingNameTo: infoFrom)
            }
            
            let deleteAction = UIAlertAction(title: "Delete", style: .default) { (action) in
                self.deleteFavPin(selectedPin: dropPin)
            }
            
            let FromAction = UIAlertAction(title: "From", style: .default) { (action) in
                self.FromSearch.text = dropPin.title
            }
            
            let ToAction = UIAlertAction(title: "To", style: .default) { (action) in
                self.ToSearch.text = dropPin.title
            }
            alertView.addAction(FromAction)
            alertView.addAction(ToAction)
            
            alertView.addAction(actionDirection)
            alertView.addAction(deleteAction)

            
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertView.addAction(actionCancel)
            self.present(alertView, animated: true, completion: nil)
        default:
            break
        }
    }
    
    
    //MARK: - Category Delegate
    func display(section: Int, row: Int) {
        dismiss(animated: true, completion: nil)
        displayCategory(section: section, row: row)
        
    }
    

    @IBAction func cancelSearch(segue:UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    func zoomMap() {
        var region: MKCoordinateRegion = self.mapView.region
        var span: MKCoordinateSpan = mapView.region.span
        span.latitudeDelta = zoomDelta
        span.longitudeDelta = zoomDelta
        region.span = span
        mapView.setRegion(region, animated: true)
    }
    
    //MARK: - Local Search
    func displayCategory(section: Int, row: Int) {
        let request = MKLocalSearchRequest()
        request.region = mapView.region
        let name = mapModel.eachRowsInSection(index: section)[row]
        let latitude = mapModel.eachRowsLatInSection(index: section)[row]
        let long = mapModel.eachRowsLongInSection(index: section)[row]
        let latLongLocation = CLLocationCoordinate2D(latitude: latitude, longitude: long)
        let favpinAnnotation = FavPin(title: name, coordinate: latLongLocation)
        let pinAnnotation = DroppedPin(title: name, coordinate: latLongLocation)
        let indexNumber = mapModel.getRowDetail(section: section, row: row)
        if isChecked[indexNumber]==true{
            onlyFavoritePin.append(favpinAnnotation)
            mapView.addAnnotation(favpinAnnotation)
        }
        else{
            onlyNotFavoritePin.append(pinAnnotation)
            mapView.addAnnotation(pinAnnotation)
        }
        favoritePin.append(pinAnnotation)
        zoomMap()
        mapView.setCenter(latLongLocation, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "CategorySegue":
            let navController = segue.destination as! UINavigationController
           let categoryViewController = navController.topViewController as! CategoryTableViewController
            categoryViewController.delegate = self
            categoryViewController.isChecked = isChecked
            categoryViewController.FavData = FavData
            categoryViewController.recievedIndexPath = recievedIndexPath
            categoryViewController.savedTextView = saveTextView
            categoryViewController.changedHeightCate = changedHeightMap
        case "ListDirection":
            let navController = segue.destination as! ListDirectionTableController
            navController.delegate = self
            navController.direction = direction
            navController.stepCoordinateArray = stepCoordinateArray
            navController.savedTextView = saveTextView
            navController.changedHeightList = changedHeightMap
            
        default:
            assert(false, "Unhandled Segue")
        }
    }
    

}
