//
//  FirstViewController.swift
//  Tripless
//
//  Created by hko on 11/10/18.
//  Copyright © 2018 hko. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    fileprivate var locationManager: CLLocationManager = CLLocationManager()
    weak var tripDBHelperDelegate: TripDBHelper?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        mapView.showsCompass = true
        mapView.showsUserLocation = true
        
        centerToCurrentLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // test trip in boston
        tripDBHelperDelegate!.saveTrip(trip: Trip(latitude: 42.3601, longitude: 71.0589))
        
        loadData()
    }
    
    private func loadData()
    {
        let tripData = tripDBHelperDelegate!.getAllTripData()
        mapView.addAnnotations(tripData.map
            { trip in
                let pointAnnotation = MKPointAnnotation()
                pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: trip.lat, longitude: trip.long)
                pointAnnotation.title = "1"
                
                return pointAnnotation
        })
    }
    
    private func centerToCurrentLocation()
    {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

}

// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        guard let location = locations.first else { return }
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(coordinateRegion, animated: true)
        
        locationManager.stopUpdatingLocation()
    }
}
