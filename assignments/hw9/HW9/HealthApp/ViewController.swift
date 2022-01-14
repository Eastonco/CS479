//
//  ViewController.swift
//  HealthApp
//
//  Created by Connor Easton on 3/23/21.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBAction func startPressed(_ sender: Any) {
        startLocation()
    }
    @IBAction func stopPressed(_ sender: Any) {
        stopLocation()
    }
    
    @IBOutlet weak var distanceTraveledLabel: UILabel!
    @IBOutlet weak var nearestHospitalLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    

    var lastLocationhelper:CLLocation? = nil
    var totalDistance:Double = 0
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeLocation()
        // Do any additional setup after loading the view.
    }
    
    func initializeLocation() {
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        let status = locationManager.authorizationStatus
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("location authorized")
        case .denied:
            print("location denied")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            print("loc unknown")
        }
    }
    
    func searchMap(_ query:String){
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: searchHandler)
    }
    
    func searchHandler(response: MKLocalSearch.Response?, error: Error?){
        if let err = error{
            print("Error occoiursed in search: \(err.localizedDescription)")
            nearestHospitalLabel.text = "Nearest Hospital: ?"
        } else if let resp = response{
            print("\(resp.mapItems.count) matches found")
            self.mapView.removeAnnotations(self.mapView.annotations)
            
            let closest = resp.mapItems[0]
            let annotation = MKPointAnnotation()
            annotation.coordinate = closest.placemark.coordinate
            annotation.title = closest.name
            self.mapView.addAnnotation(annotation)
            nearestHospitalLabel.text = "Nearest Hospital: " + closest.name!
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if((status == .authorizedAlways) || (status == .authorizedWhenInUse)){
            print("location changed to authorized")
        } else {
            print("loc not authorized")
            self.stopLocation()
        }
    }
    
    func startLocation(){
        let status = locationManager.authorizationStatus
        if (status == .authorizedAlways) || (status == .authorizedWhenInUse){
            locationManager.startUpdatingLocation()
        }
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    func stopLocation() {
        mapView.showsUserLocation = false
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        searchMap("hospital")
        
        
        if let location = locations.last{
            if lastLocationhelper != nil{
                totalDistance += location.distance(from: lastLocationhelper!)
                lastLocationhelper = location
                distanceTraveledLabel.text = "Distance Traveled: " + String(totalDistance)
            }
            lastLocationhelper = location
            if let annotation = self.mapView.annotations.last {
                let hospital = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
                distanceLabel.text = "Distance: " + String((location.distance(from: hospital)))
            }
            
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManager error: \(error.localizedDescription)")
    }

}

