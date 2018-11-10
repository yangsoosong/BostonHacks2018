//
//  TabBarController.swift
//  Tripless
//
//  Created by Ivan Chen on 11/10/18.
//  Copyright © 2018 hko. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        selectedIndex = 0
        
        self.delegate = self
        
        if let mapViewController = selectedViewController as? MapViewController
        {
            // do something before launching MapViewController
        }
    }
}

// MARK: - UITabBarControllerDelegate
extension TabBarController: UITabBarControllerDelegate
{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool
    {
        switch viewController
        {
        case is MapViewController:
            if let mapViewController = viewController as? MapViewController
            {
                // do something before launching MapViewController
            }
        case is LogViewController:
            if let cameraViewController = viewController as? LogViewController
            {
                // do something before launching LogViewController
            }
        default:
            print("do nothing")
        }
        return true
    }
}

