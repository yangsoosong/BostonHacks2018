//
//  Trip.swift
//  Tripless
//
//  Created by Ivan Chen on 11/10/18.
//  Copyright © 2018 hko. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class Trip
{
    let latitude: Double
    let longitude: Double
    
    init(latitude: Double, longitude: Double)
    {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    static func == (lhs: Trip, rhs: Trip) -> Bool
    {
        return
            lhs.latitude == rhs.latitude &&
            lhs.longitude == rhs.longitude
    }
    
}
