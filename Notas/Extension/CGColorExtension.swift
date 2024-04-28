//
//  CGColorExtension.swift
//  Notas
//
//  Created by Abraham Valderrabano Vega on 25/04/24.
//

import Foundation
import UIKit

public extension CGColor {
    var UIColor : UIKit.UIColor {
        return UIKit.UIColor(cgColor: self)
    }
}
