//
//  TabBarController.swift
//  Tripless
//
//  Created by Ivan Chen on 11/10/18.
//  Copyright © 2018 hko. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    fileprivate var tripDBHelper = TripDBHelper(appDelegate: (UIApplication.shared.delegate as? AppDelegate)!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = 0
        
        self.delegate = self
        
        if let mapViewController = selectedViewController as? MapViewController {
            mapViewController.tripDBHelperDelegate = tripDBHelper
        }
    }
}

// MARK: - UITabBarControllerDelegate
extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        switch viewController {
        case is MapViewController:
            if let mapViewController = viewController as? MapViewController
            {
                mapViewController.tripDBHelperDelegate = tripDBHelper
            }
        case is LogViewController:
            if let logViewController = viewController as? LogViewController
            {
                logViewController.tripDBHelperDelegate = tripDBHelper
            }
        default:
            print("do nothing")
        }
        return true
    }
}

