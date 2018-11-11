//
//  MapViewController
//  Tripless
//
//  Created by hko on 11/10/18.
//  Copyright © 2018 hko. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import UserNotifications

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
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler:
        { didAllow, error in
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
        
        //creating the notification content
        let content = UNMutableNotificationContent()
        
        //adding title, subtitle, body and badge
        content.title = "Hey this is Simplified iOS"
        content.subtitle = "iOS Development is fun"
        content.body = "We are learning about iOS Local Notification"
        content.badge = 1
        
        //getting the notification trigger
        //it will be called after 5 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        //getting the notification request
        let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification1", content: content, trigger: trigger)
        
        //adding the notification to notification center
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    private func loadData() {
        let tripData = tripDBHelperDelegate!.getAllTripData()
        mapView.addAnnotations(tripData.map
            { trip in
                let pointAnnotation = MKPointAnnotation()
                pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: trip.lat, longitude: trip.long)
                pointAnnotation.title = "1"
                
                return pointAnnotation
        })
        
    }
    
    private func centerToCurrentLocation() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

}

extension MapViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("tapped?")
        
        //displaying the ios local notification when app is in foreground
        completionHandler([.alert, .badge, .sound])
    }
}

// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(coordinateRegion, animated: true)
        
        locationManager.stopUpdatingLocation()
    }
}
