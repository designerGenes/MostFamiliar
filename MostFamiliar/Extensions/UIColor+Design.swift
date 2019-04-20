//
//  UIColor+Design.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/9/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework

extension UIColor {
    class func darkPurple() -> UIColor { return UIColor(hexString: "#2F195F") }
    class func brightRed() -> UIColor { return UIColor(hexString: "#DB5461") }
    class func limeGreen() -> UIColor { return UIColor(hexString: "#B8E986") }
    class func lightPurple() -> UIColor { return UIColor(hexString: "#9877B5") }
    class func bgroundGray() -> UIColor { return UIColor(hexString: "#F7F7F7") }
    class func skyBlue() -> UIColor { return UIColor(hexString: "#5EAEDF") }
    class func spotifyGray() -> UIColor { return UIColor(hexString: "#1F2124") }
    class func spotifyDarkGray() -> UIColor { return UIColor(hexString: "#121212") }
    class func spotifyGreen() -> UIColor { return UIColor(hexString: "#55B761") }
    
    class func randomProjectColor(notColor: UIColor? = nil) -> UIColor {
        let colors = [darkPurple(), brightRed(), limeGreen(), lightPurple(), skyBlue()].filter({$0 != notColor})
        return colors[randomInt(upperBound: colors.count)] ?? UIColor.bgroundGray()
    }
}
