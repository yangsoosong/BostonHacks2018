//
//  TripDBHelper.swift
//  Tripless
//
//  Created by Ivan Chen on 11/10/18.
//  Copyright © 2018 hko. All rights reserved.
//

import Foundation
import UIKit

class TripDBHelper
{
    private var tripData: [TripData] = []
    private weak var appDelegate: AppDelegate!
    
    init(appDelegate: AppDelegate)
    {
        self.appDelegate = appDelegate
        reloadData()
    }
    
    func getAllTripData() -> [TripData]
    {
        return tripData
    }
    
    func getTripData(at index: Int) -> TripData
    {
        return tripData[index]
    }
    
    func removeTrip(trip: TripData)
    {
        appDelegate.persistentContainer.viewContext.delete(trip)
        appDelegate.saveContext()
        
        reloadData()
    }
    
    func saveTrip(trip: Trip)
    {
        let tripData = TripData(context: appDelegate.persistentContainer.viewContext)
        tripData.lat = trip.latitude
        tripData.long = trip.longitude
        
        appDelegate.saveContext()
        
        print("saved trip: (\(trip.latitude), \(trip.longitude))")
        
        reloadData()
    }
    
    private func reloadData()
    {
        do
        {
            tripData = try appDelegate.persistentContainer.viewContext.fetch(TripData.fetchRequest())
        }
        catch
        {
            print("Fetching Fialed")
        }
    }
}
