//
//  LogCell.swift
//  Tripless
//
//  Created by Ivan Chen on 11/10/18.
//  Copyright © 2018 hko. All rights reserved.
//

import Foundation
import UIKit

class LogCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    var logData: (label: String, _: Any)? {
        didSet {
            label.text = logData?.label
        }
    }
}
